// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  amount: (json['amount'] as num).toDouble(),
  kind: $enumDecode(_$TransactionKindEnumMap, json['kind']),
  status:
      $enumDecodeNullable(_$TransactionStatusEnumMap, json['status']) ??
      TransactionStatus.completed,
  date: DateTime.parse(json['date'] as String),
  category: json['category'] as String? ?? '',
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'amount': instance.amount,
  'kind': _$TransactionKindEnumMap[instance.kind]!,
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'date': instance.date.toIso8601String(),
  'category': instance.category,
};

const _$TransactionKindEnumMap = {
  TransactionKind.transfer: 'transfer',
  TransactionKind.deposit: 'deposit',
  TransactionKind.withdrawal: 'withdrawal',
  TransactionKind.payment: 'payment',
  TransactionKind.income: 'income',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.completed: 'completed',
  TransactionStatus.pending: 'pending',
  TransactionStatus.failed: 'failed',
};
