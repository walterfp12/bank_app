// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentCardModelImpl _$$PaymentCardModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentCardModelImpl(
  id: json['id'] as String,
  number: json['number'] as String,
  holderName: json['holderName'] as String,
  expiryDate: json['expiryDate'] as String,
  type: $enumDecode(_$CardTypeEnumMap, json['type']),
  brand: $enumDecode(_$CardBrandEnumMap, json['brand']),
  creditLimit: (json['creditLimit'] as num?)?.toDouble(),
  usedCredit: (json['usedCredit'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$PaymentCardModelImplToJson(
  _$PaymentCardModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'holderName': instance.holderName,
  'expiryDate': instance.expiryDate,
  'type': _$CardTypeEnumMap[instance.type]!,
  'brand': _$CardBrandEnumMap[instance.brand]!,
  'creditLimit': instance.creditLimit,
  'usedCredit': instance.usedCredit,
};

const _$CardTypeEnumMap = {
  CardType.debit: 'debit',
  CardType.credit: 'credit',
  CardType.prepaid: 'prepaid',
};

const _$CardBrandEnumMap = {
  CardBrand.visa: 'visa',
  CardBrand.mastercard: 'mastercard',
  CardBrand.amex: 'amex',
};
