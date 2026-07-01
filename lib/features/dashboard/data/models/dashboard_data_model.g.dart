// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardDataModelImpl _$$DashboardDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardDataModelImpl(
  userName: json['userName'] as String,
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  cards: (json['cards'] as List<dynamic>)
      .map((e) => PaymentCardModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  recentTransactions: (json['recentTransactions'] as List<dynamic>)
      .map((e) => RecentTransactionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$DashboardDataModelImplToJson(
  _$DashboardDataModelImpl instance,
) => <String, dynamic>{
  'userName': instance.userName,
  'accounts': instance.accounts,
  'cards': instance.cards,
  'recentTransactions': instance.recentTransactions,
};
