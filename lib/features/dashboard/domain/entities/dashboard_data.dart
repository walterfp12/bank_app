import 'package:freezed_annotation/freezed_annotation.dart';
import 'account.dart';
import 'payment_card.dart';
import 'recent_transaction.dart';

part 'dashboard_data.freezed.dart';

/// Agregado de todo lo que muestra el dashboard — capa Domain (Freezed).
///
/// El Notifier devuelve este objeto dentro de su estado, no listas sueltas.
@freezed
class DashboardData with _$DashboardData {
  const DashboardData._();

  const factory DashboardData({
    required String userName,
    required List<Account> accounts,
    required List<PaymentCard> cards,
    required List<RecentTransaction> recentTransactions,
  }) = _DashboardData;

  /// Saldo total sumando el balance de todas las cuentas.
  double get totalBalance =>
      accounts.fold(0, (sum, acc) => sum + acc.balance);

  /// Iniciales del usuario para el avatar.
  String get userInitials {
    final parts =
        userName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
