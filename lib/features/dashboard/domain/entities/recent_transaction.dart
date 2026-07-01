import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_transaction.freezed.dart';

/// Tipo de movimiento
enum TransactionKind { transfer, deposit, withdrawal, payment, income }

/// Entidad de movimiento reciente — capa Domain (Freezed).
@freezed
class RecentTransaction with _$RecentTransaction {
  const RecentTransaction._();

  const factory RecentTransaction({
    required String id,
    required String title,
    required double amount,
    required TransactionKind kind,
    required DateTime date,
  }) = _RecentTransaction;

  /// True si el movimiento suma saldo (depósito o ingreso).
  bool get isIncome =>
      kind == TransactionKind.deposit || kind == TransactionKind.income;
}
