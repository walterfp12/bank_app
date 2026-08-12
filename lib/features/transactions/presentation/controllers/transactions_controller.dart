import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/states/auth_state.dart';
import '../../domain/entities/transaction_page.dart';
import '../providers/transactions_providers.dart';
import '../states/transactions_state.dart';

/// Controller del historial – capa Presentation (HU 4.2).
///
/// Devuelve un [TransactionsState] propio. Gestiona tres operaciones:
/// carga inicial, carga de la siguiente página (scroll infinito) y sembrado
/// de datos de demostración.
class TransactionsController extends Notifier<TransactionsState> {
  /// Este controller observa la sesión, así que puede reconstruirse mientras
  /// hay una consulta en vuelo. Estas dos banderas evitan que una respuesta
  /// tardía escriba sobre un estado más nuevo o sobre un notifier ya desechado.
  bool _disposed = false;
  int _requestId = 0;

  @override
  TransactionsState build() {
    // Recargar cuando cambie el usuario autenticado.
    ref.watch(authControllerProvider);

    _disposed = false;
    ref.onDispose(() => _disposed = true);

    Future.microtask(loadFirstPage);
    return const TransactionsState.initial();
  }

  /// uid del usuario autenticado; null si no hay sesión.
  String? get _userId {
    final auth = ref.read(authControllerProvider);
    return auth is AuthStateAuthenticated ? auth.session.user.id : null;
  }

  /// True si esta petición sigue siendo la vigente.
  bool _isCurrent(int requestId) => !_disposed && requestId == _requestId;

  // ─── Carga inicial ──────────────────────────────────────────────────────────

  Future<void> loadFirstPage() async {
    final requestId = ++_requestId;

    final userId = _userId;
    if (userId == null) {
      if (_isCurrent(requestId)) state = const TransactionsState.initial();
      return;
    }

    state = const TransactionsState.loading();

    final result =
        await ref.read(getTransactionsPageUseCaseProvider).call(userId: userId);

    // Llegó tarde: hubo otra carga o el provider se destruyó.
    if (!_isCurrent(requestId)) return;

    result.when(
      success: (page) => state = _toLoaded(page),
      failure: (error) =>
          state = TransactionsState.error(message: error.friendlyMessage),
    );
  }

  // ─── Siguiente página (scroll infinito) ─────────────────────────────────────

  Future<void> loadMore() async {
    final current = state;

    // Solo se pagina desde un estado con datos, si quedan páginas y si no hay
    // otra carga en curso. Este guard evita disparos múltiples del scroll.
    if (current is! TransactionsLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    final userId = _userId;
    if (userId == null) return;

    final requestId = ++_requestId;
    state = current.copyWith(isLoadingMore: true, paginationError: null);

    final result = await ref
        .read(getTransactionsPageUseCaseProvider)
        .call(userId: userId, cursor: current.cursor);

    if (!_isCurrent(requestId)) return;

    // Se relee el estado en vez de usar el capturado antes del await: así se
    // parte siempre de los datos vigentes.
    final latest = state;
    if (latest is! TransactionsLoaded) return;

    result.when(
      success: (page) {
        state = latest.copyWith(
          items: [...latest.items, ...page.items],
          hasMore: page.hasMore,
          cursor: page.nextCursor,
          isLoadingMore: false,
        );
      },
      failure: (error) {
        // Se conservan los items ya cargados y se reporta el fallo aparte.
        state = latest.copyWith(
          isLoadingMore: false,
          paginationError: error.friendlyMessage,
        );
      },
    );
  }

  // ─── Utilidades ─────────────────────────────────────────────────────────────

  Future<void> refresh() => loadFirstPage();

  /// Inserta las transacciones de demostración en Firestore y recarga.
  ///
  /// Devuelve cuántas se crearon y, si algo falló, el mensaje de error. Se
  /// distinguen los tres casos —creadas, ya existían, o falló— porque un 0
  /// a secas confundiría un error de permisos con "ya había datos".
  Future<({int inserted, String? error})> seedDemoData() async {
    final userId = _userId;
    if (userId == null) {
      return (inserted: 0, error: 'No hay una sesión activa.');
    }

    final result =
        await ref.read(seedTransactionsUseCaseProvider).call(userId: userId);

    final error = result.errorOrNull;
    if (error != null) {
      return (inserted: 0, error: error.friendlyMessage);
    }

    await loadFirstPage();
    return (inserted: result.dataOrNull ?? 0, error: null);
  }

  TransactionsState _toLoaded(TransactionPage page) {
    if (page.items.isEmpty) return const TransactionsState.empty();
    return TransactionsState.loaded(
      items: page.items,
      hasMore: page.hasMore,
      cursor: page.nextCursor,
    );
  }
}

final transactionsControllerProvider =
    NotifierProvider<TransactionsController, TransactionsState>(
  TransactionsController.new,
);
