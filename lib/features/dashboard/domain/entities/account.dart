import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

/// Tipo de cuenta bancaria
enum AccountType { savings, checking, credit }

/// Entidad de cuenta bancaria — capa Domain (Dart puro, sin dependencias externas).
///
/// Usa Freezed para inmutabilidad, `copyWith` y comparación por valor.
@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String number,
    required String name,
    required AccountType type,
    required double balance,
    required double availableBalance,
    @Default('GTQ') String currency,
  }) = _Account;
}
