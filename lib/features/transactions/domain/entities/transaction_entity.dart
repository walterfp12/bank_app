import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

/// Tipo de movimiento bancario
enum TransactionKind { transfer, deposit, withdrawal, payment, income }

/// Estado del movimiento
enum TransactionStatus { completed, pending, failed }

/// Entidad de transacción – capa Domain (Freezed, Dart puro).
///
/// No conoce Firestore ni JSON: el mapeo vive en `TransactionModel` (capa Data).
@freezed
class TransactionEntity with _$TransactionEntity {
  const TransactionEntity._();

  const factory TransactionEntity({
    required String id,
    required String title,
    required String description,
    required double amount,
    required TransactionKind kind,
    required TransactionStatus status,
    required DateTime date,
    @Default('') String category,
  }) = _TransactionEntity;

  /// True si el movimiento suma saldo.
  bool get isIncome =>
      kind == TransactionKind.deposit || kind == TransactionKind.income;
}
