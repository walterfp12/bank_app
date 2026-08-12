import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transactions_state.freezed.dart';

/// Estado del historial de transacciones – capa Presentation (HU 4.2).
///
/// El Notifier devuelve SIEMPRE una de estas variantes, nunca una lista suelta.
/// La paginación necesita más que "cargando o cargado": hay que distinguir la
/// carga inicial (pantalla completa) de la carga de la siguiente página (spinner
/// al final de la lista, con los datos ya visibles). Por eso [loaded] lleva
/// [isLoadingMore] y [hasMore] dentro del mismo estado.
@freezed
sealed class TransactionsState with _$TransactionsState {
  /// Aún no se ha pedido nada.
  const factory TransactionsState.initial() = TransactionsInitial;

  /// Cargando la primera página.
  const factory TransactionsState.loading() = TransactionsLoading;

  /// El usuario no tiene transacciones registradas.
  const factory TransactionsState.empty() = TransactionsEmpty;

  /// Hay datos en pantalla.
  const factory TransactionsState.loaded({
    required List<TransactionEntity> items,

    /// Quedan más páginas por traer.
    required bool hasMore,

    /// Se está trayendo la siguiente página (los items actuales siguen visibles).
    @Default(false) bool isLoadingMore,

    /// Cursor de la siguiente página.
    DateTime? cursor,

    /// Error al traer la siguiente página, sin perder lo ya cargado.
    String? paginationError,
  }) = TransactionsLoaded;

  /// Error en la carga inicial.
  const factory TransactionsState.error({required String message}) =
      TransactionsError;
}
