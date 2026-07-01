import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dashboard_data.dart';
import 'account_model.dart';
import 'payment_card_model.dart';
import 'recent_transaction_model.dart';

part 'dashboard_data_model.freezed.dart';
part 'dashboard_data_model.g.dart';

/// Modelo agregado del dashboard — capa Data (Freezed + JSON).
///
/// Es lo que se serializa a JSON para la caché local en SharedPreferences y
/// lo que devuelve el DataSource remoto (mock). `toDomain()` produce la entidad.
@freezed
class DashboardDataModel with _$DashboardDataModel {
  const DashboardDataModel._();

  const factory DashboardDataModel({
    required String userName,
    required List<AccountModel> accounts,
    required List<PaymentCardModel> cards,
    required List<RecentTransactionModel> recentTransactions,
  }) = _DashboardDataModel;

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);

  DashboardData toDomain() => DashboardData(
        userName: userName,
        accounts: accounts.map((a) => a.toDomain()).toList(),
        cards: cards.map((c) => c.toDomain()).toList(),
        recentTransactions:
            recentTransactions.map((t) => t.toDomain()).toList(),
      );
}
