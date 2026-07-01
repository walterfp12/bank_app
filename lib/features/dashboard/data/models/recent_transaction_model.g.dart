// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecentTransactionModelImpl _$$RecentTransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecentTransactionModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  amount: (json['amount'] as num).toDouble(),
  kind: $enumDecode(_$TransactionKindEnumMap, json['kind']),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$RecentTransactionModelImplToJson(
  _$RecentTransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'amount': instance.amount,
  'kind': _$TransactionKindEnumMap[instance.kind]!,
  'date': instance.date.toIso8601String(),
};

const _$TransactionKindEnumMap = {
  TransactionKind.transfer: 'transfer',
  TransactionKind.deposit: 'deposit',
  TransactionKind.withdrawal: 'withdrawal',
  TransactionKind.payment: 'payment',
  TransactionKind.income: 'income',
};
