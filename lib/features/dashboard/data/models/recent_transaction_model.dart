import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/recent_transaction.dart';

part 'recent_transaction_model.freezed.dart';
part 'recent_transaction_model.g.dart';

/// Modelo de movimiento — capa Data (Freezed + JSON).
@freezed
class RecentTransactionModel with _$RecentTransactionModel {
  const RecentTransactionModel._();

  const factory RecentTransactionModel({
    required String id,
    required String title,
    required double amount,
    required TransactionKind kind,
    required DateTime date,
  }) = _RecentTransactionModel;

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$RecentTransactionModelFromJson(json);

  RecentTransaction toDomain() => RecentTransaction(
        id: id,
        title: title,
        amount: amount,
        kind: kind,
        date: date,
      );
}
