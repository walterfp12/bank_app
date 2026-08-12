import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/utils/format_utils.dart';
import '../../domain/entities/transaction_entity.dart';
import '../controllers/transactions_controller.dart';
import '../states/transactions_state.dart';

/// HU 4.2 – Historial de transacciones desde Firestore con consultas paginadas.
///
/// La pantalla solo lee [TransactionsState] y hace pattern matching exhaustivo.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  /// Dispara la siguiente página cuando faltan ~300 px para el final.
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(transactionsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionsControllerProvider);
    final controller = ref.read(transactionsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          // Demo del módulo: puebla Firestore para mostrar el paginado.
          IconButton(
            tooltip: 'Sembrar datos de prueba',
            icon: const Icon(Icons.cloud_upload_outlined),
            onPressed: () => _seed(controller),
          ),
        ],
      ),
      body: switch (state) {
        TransactionsInitial() || TransactionsLoading() => const _Loading(),
        TransactionsEmpty() => _Empty(onSeed: () => _seed(controller)),
        TransactionsError(:final message) => _ErrorView(
            message: message,
            onRetry: controller.refresh,
          ),
        TransactionsLoaded() => _List(
            state: state,
            scrollController: _scrollController,
            onRefresh: controller.refresh,
            onRetryPage: controller.loadMore,
          ),
      },
    );
  }

  Future<void> _seed(TransactionsController controller) async {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Insertando transacciones en Firestore…')),
    );

    final result = await controller.seedDemoData();
    if (!mounted) return;

    // Tres desenlaces distintos: error, ya existían, o se crearon.
    final (text, color) = switch (result) {
      (inserted: _, error: final e?) => ('No se pudo sembrar: $e', AppColors.error),
      (inserted: 0, error: _) => (
          'Ya existían transacciones para este usuario',
          AppColors.warning,
        ),
      (inserted: final n, error: _) => (
          '$n transacciones creadas en Firestore',
          AppColors.success,
        ),
    };

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color),
    );
  }
}

// ─── Estado: cargando primera página ──────────────────────────────────────────

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

// ─── Estado: sin transacciones ────────────────────────────────────────────────

class _Empty extends StatelessWidget {
  final VoidCallback onSeed;
  const _Empty({required this.onSeed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined,
                size: 56, color: AppColors.textLight),
            const SizedBox(height: AppDimens.paddingMD),
            Text(
              'Sin movimientos',
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontLG,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              'Tu colección de Firestore está vacía.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontSM,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingLG),
            FilledButton.icon(
              onPressed: onSeed,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Cargar datos de prueba'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Estado: error en la carga inicial ────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 56, color: AppColors.error),
            const SizedBox(height: AppDimens.paddingMD),
            Text(
              'No se pudo cargar el historial',
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontLG,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontSM,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingLG),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Estado: lista con paginación ─────────────────────────────────────────────

class _List extends StatelessWidget {
  final TransactionsLoaded state;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetryPage;

  const _List({
    required this.state,
    required this.scrollController,
    required this.onRefresh,
    required this.onRetryPage,
  });

  @override
  Widget build(BuildContext context) {
    // Una fila extra al final para el indicador de paginación.
    final itemCount = state.items.length + 1;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: ListView.separated(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimens.paddingLG),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: AppDimens.marginSM),
        itemBuilder: (context, index) {
          if (index < state.items.length) {
            return _TransactionTile(tx: state.items[index]);
          }
          return _PaginationFooter(state: state, onRetry: onRetryPage);
        },
      ),
    );
  }
}

/// Pie de la lista: spinner, error de página o mensaje de fin.
class _PaginationFooter extends StatelessWidget {
  final TransactionsLoaded state;
  final VoidCallback onRetry;

  const _PaginationFooter({required this.state, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    if (state.paginationError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingLG),
        child: Column(
          children: [
            Text(
              'No se pudo cargar más',
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontSM,
                color: AppColors.error,
              ),
            ),
            TextButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      );
    }

    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.paddingLG),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.primary,
            ),
          ),
        ),
      );
    }

    if (!state.hasMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingLG),
        child: Center(
          child: Text(
            '${state.items.length} movimientos · fin del historial',
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontSM,
              color: AppColors.textLight,
            ),
          ),
        ),
      );
    }

    return const SizedBox(height: AppDimens.paddingLG);
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionEntity tx;
  const _TransactionTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.isIncome;
    final color = isIncome ? AppColors.income : AppColors.expense;

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusSM),
            ),
            alignment: Alignment.center,
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        FormatUtils.dateRelative(tx.date),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: AppDimens.fontSM,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                    if (tx.status == TransactionStatus.pending) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Pendiente',
                          style: GoogleFonts.inter(
                            fontSize: AppDimens.fontXS,
                            color: AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimens.paddingSM),
          Text(
            '${isIncome ? '+' : '-'}${FormatUtils.currency(tx.amount)}',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: AppDimens.fontMD,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
