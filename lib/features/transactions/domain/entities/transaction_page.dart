import 'package:freezed_annotation/freezed_annotation.dart';
import 'transaction_entity.dart';

part 'transaction_page.freezed.dart';

/// Página de resultados – capa Domain (HU 4.2).
///
/// Representa el resultado de una consulta paginada sin exponer tipos de
/// Firestore. El cursor es la fecha del último elemento: con eso la capa Data
/// arma el `startAfter` de la siguiente consulta, y el dominio se mantiene puro.
@freezed
class TransactionPage with _$TransactionPage {
  const factory TransactionPage({
    required List<TransactionEntity> items,

    /// Indica si quedan más documentos por traer.
    required bool hasMore,

    /// Cursor para la siguiente página (null si ya no hay más).
    DateTime? nextCursor,
  }) = _TransactionPage;
}
