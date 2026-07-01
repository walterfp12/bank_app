// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountModelImpl _$$AccountModelImplFromJson(Map<String, dynamic> json) =>
    _$AccountModelImpl(
      id: json['id'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$AccountTypeEnumMap, json['type']),
      balance: (json['balance'] as num).toDouble(),
      availableBalance: (json['availableBalance'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'GTQ',
    );

Map<String, dynamic> _$$AccountModelImplToJson(_$AccountModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'name': instance.name,
      'type': _$AccountTypeEnumMap[instance.type]!,
      'balance': instance.balance,
      'availableBalance': instance.availableBalance,
      'currency': instance.currency,
    };

const _$AccountTypeEnumMap = {
  AccountType.savings: 'savings',
  AccountType.checking: 'checking',
  AccountType.credit: 'credit',
};
