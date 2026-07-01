import '../models/account_model.dart';
import '../models/dashboard_data_model.dart';
import '../models/payment_card_model.dart';
import '../models/recent_transaction_model.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/payment_card.dart';
import '../../domain/entities/recent_transaction.dart';

/// DataSource remoto del dashboard — capa Data.
///
/// Contrato + implementación MOCK. Aunque los datos están hardcodeados, viven
/// aquí (no en la UI) para que reemplazarlos por una llamada real a Firebase /
/// API en M4 sea cambiar SOLO esta clase, sin tocar repositorio, casos de uso
/// ni pantallas.
abstract interface class DashboardRemoteDataSource {
  Future<DashboardDataModel> fetchDashboard();
}

class DashboardRemoteDataSourceMock implements DashboardRemoteDataSource {
  const DashboardRemoteDataSourceMock();

  @override
  Future<DashboardDataModel> fetchDashboard() async {
    // Simula latencia de red para poder mostrar el estado de carga.
    await Future.delayed(const Duration(milliseconds: 1200));

    return DashboardDataModel(
      userName: 'Walter Fuentes',
      accounts: const [
        AccountModel(
          id: 'acc_001',
          number: '0012345678901',
          name: 'Ahorro Principal',
          type: AccountType.savings,
          balance: 45750.50,
          availableBalance: 45750.50,
        ),
        AccountModel(
          id: 'acc_002',
          number: '0019876543210',
          name: 'Cuenta Corriente',
          type: AccountType.checking,
          balance: 12300.00,
          availableBalance: 12300.00,
        ),
        AccountModel(
          id: 'acc_003',
          number: '4000123456789012',
          name: 'Visa Platinum',
          type: AccountType.credit,
          balance: -8500.75,
          availableBalance: 41499.25,
        ),
      ],
      cards: const [
        PaymentCardModel(
          id: 'card_001',
          number: '4000 1234 5678 9012',
          holderName: 'WALTER FUENTES',
          expiryDate: '12/28',
          type: CardType.debit,
          brand: CardBrand.visa,
        ),
        PaymentCardModel(
          id: 'card_002',
          number: '5200 9876 5432 1098',
          holderName: 'WALTER FUENTES',
          expiryDate: '06/27',
          type: CardType.credit,
          brand: CardBrand.mastercard,
          creditLimit: 50000.00,
          usedCredit: 8500.75,
        ),
        PaymentCardModel(
          id: 'card_003',
          number: '3400 5678 9012 345',
          holderName: 'WALTER FUENTES',
          expiryDate: '03/29',
          type: CardType.prepaid,
          brand: CardBrand.amex,
        ),
      ],
      recentTransactions: [
        RecentTransactionModel(
          id: 'txn_001',
          title: 'Transferencia a María López',
          amount: 3500.00,
          kind: TransactionKind.transfer,
          date: _daysAgo(0, hours: 2),
        ),
        RecentTransactionModel(
          id: 'txn_002',
          title: 'Depósito recibido - Nómina',
          amount: 12500.00,
          kind: TransactionKind.deposit,
          date: _daysAgo(1),
        ),
        RecentTransactionModel(
          id: 'txn_003',
          title: 'Pago Supermercado La Torre',
          amount: 850.25,
          kind: TransactionKind.payment,
          date: _daysAgo(2),
        ),
        RecentTransactionModel(
          id: 'txn_004',
          title: 'Retiro ATM Centro Comercial',
          amount: 2000.00,
          kind: TransactionKind.withdrawal,
          date: _daysAgo(3),
        ),
        RecentTransactionModel(
          id: 'txn_005',
          title: 'Transferencia recibida - Carlos Pérez',
          amount: 5000.00,
          kind: TransactionKind.income,
          date: _daysAgo(5),
        ),
      ],
    );
  }
}

/// Fechas relativas fijas para que el mock sea `const`-compatible en runtime.
DateTime _daysAgo(int days, {int hours = 0}) =>
    DateTime.now().subtract(Duration(days: days, hours: hours));
