import '../features/accounts/models/bank_account.dart';
import '../features/transactions/models/transaction.dart';
import '../features/cards/models/bank_card.dart';
import 'user_profile.dart';

/// Servicio de datos de demostración para desarrollo
/// Reemplazar con API real en producción
class MockDataService {
  MockDataService._();

  static UserProfile get currentUser => UserProfile(
        id: 'usr_001',
        fullName: 'Walter Fuentes',
        email: 'walter.fuentes@email.com',
        phone: '+502 5555-1234',
        dpi: '1234567890101',
        dateOfBirth: DateTime(1995, 6, 15),
        createdAt: DateTime(2024, 1, 15),
      );

  static List<BankAccount> get accounts => [
        const BankAccount(
          id: 'acc_001',
          accountNumber: '0012345678901',
          accountName: 'Ahorro Principal',
          type: AccountType.savings,
          balance: 45750.50,
          availableBalance: 45750.50,
        ),
        const BankAccount(
          id: 'acc_002',
          accountNumber: '0019876543210',
          accountName: 'Cuenta Corriente',
          type: AccountType.checking,
          balance: 12300.00,
          availableBalance: 12300.00,
        ),
        const BankAccount(
          id: 'acc_003',
          accountNumber: '4000123456789012',
          accountName: 'Visa Platinum',
          type: AccountType.credit,
          balance: -8500.75,
          availableBalance: 41499.25,
          currency: 'GTQ',
        ),
      ];

  static double get totalBalance =>
      accounts.fold(0, (sum, acc) => sum + acc.balance);

  static List<Transaction> get transactions => [
        Transaction(
          id: 'txn_001',
          title: 'Transferencia a María López',
          description: 'Pago alquiler febrero',
          amount: 3500.00,
          type: TransactionType.transfer,
          status: TransactionStatus.completed,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          fromAccountId: 'acc_001',
          recipientName: 'María López',
          category: 'Vivienda',
        ),
        Transaction(
          id: 'txn_002',
          title: 'Depósito recibido',
          description: 'Nómina quincenal',
          amount: 12500.00,
          type: TransactionType.deposit,
          status: TransactionStatus.completed,
          date: DateTime.now().subtract(const Duration(days: 1)),
          toAccountId: 'acc_001',
          category: 'Salario',
        ),
        Transaction(
          id: 'txn_003',
          title: 'Pago Supermercado',
          description: 'La Torre - Compras del hogar',
          amount: 850.25,
          type: TransactionType.payment,
          status: TransactionStatus.completed,
          date: DateTime.now().subtract(const Duration(days: 2)),
          fromAccountId: 'acc_003',
          category: 'Alimentación',
        ),
        Transaction(
          id: 'txn_004',
          title: 'Retiro ATM',
          description: 'Cajero Centro Comercial',
          amount: 2000.00,
          type: TransactionType.withdrawal,
          status: TransactionStatus.completed,
          date: DateTime.now().subtract(const Duration(days: 3)),
          fromAccountId: 'acc_002',
          category: 'Efectivo',
        ),
        Transaction(
          id: 'txn_005',
          title: 'Pago Netflix',
          description: 'Suscripción mensual',
          amount: 119.00,
          type: TransactionType.payment,
          status: TransactionStatus.completed,
          date: DateTime.now().subtract(const Duration(days: 4)),
          fromAccountId: 'acc_003',
          category: 'Entretenimiento',
        ),
        Transaction(
          id: 'txn_006',
          title: 'Transferencia recibida',
          description: 'De Carlos Pérez - Pago proyecto',
          amount: 5000.00,
          type: TransactionType.income,
          status: TransactionStatus.completed,
          date: DateTime.now().subtract(const Duration(days: 5)),
          toAccountId: 'acc_002',
          recipientName: 'Carlos Pérez',
          category: 'Freelance',
        ),
        Transaction(
          id: 'txn_007',
          title: 'Pago Agua',
          description: 'EMPAGUA - Servicio mensual',
          amount: 175.00,
          type: TransactionType.payment,
          status: TransactionStatus.pending,
          date: DateTime.now().subtract(const Duration(days: 1)),
          fromAccountId: 'acc_002',
          category: 'Servicios',
        ),
      ];

  static List<BankCard> get cards => [
        const BankCard(
          id: 'card_001',
          cardNumber: '4000 1234 5678 9012',
          holderName: 'WALTER FUENTES',
          expiryDate: '12/28',
          type: CardType.debit,
          brand: CardBrand.visa,
          linkedAccountId: 'acc_001',
        ),
        const BankCard(
          id: 'card_002',
          cardNumber: '5200 9876 5432 1098',
          holderName: 'WALTER FUENTES',
          expiryDate: '06/27',
          type: CardType.credit,
          brand: CardBrand.mastercard,
          creditLimit: 50000.00,
          usedCredit: 8500.75,
          linkedAccountId: 'acc_003',
        ),
      ];
}
