import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/account.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

/// Modelo de cuenta — capa Data (Freezed + JSON).
///
/// Vive en Data porque conoce el formato de serialización (JSON del backend /
/// caché). `toDomain()` lo convierte en la entidad pura de Domain.
@freezed
class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    required String id,
    required String number,
    required String name,
    required AccountType type,
    required double balance,
    required double availableBalance,
    @Default('GTQ') String currency,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Account toDomain() => Account(
        id: id,
        number: number,
        name: name,
        type: type,
        balance: balance,
        availableBalance: availableBalance,
        currency: currency,
      );
}
