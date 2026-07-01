import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payment_card.dart';

part 'payment_card_model.freezed.dart';
part 'payment_card_model.g.dart';

/// Modelo de tarjeta — capa Data (Freezed + JSON).
@freezed
class PaymentCardModel with _$PaymentCardModel {
  const PaymentCardModel._();

  const factory PaymentCardModel({
    required String id,
    required String number,
    required String holderName,
    required String expiryDate,
    required CardType type,
    required CardBrand brand,
    double? creditLimit,
    double? usedCredit,
  }) = _PaymentCardModel;

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardModelFromJson(json);

  PaymentCard toDomain() => PaymentCard(
        id: id,
        number: number,
        holderName: holderName,
        expiryDate: expiryDate,
        type: type,
        brand: brand,
        creditLimit: creditLimit,
        usedCredit: usedCredit,
      );
}
