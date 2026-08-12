import '../../../../core/errors/result.dart';
import '../entities/transaction_page.dart';

/// Contrato del repositorio de transacciones – capa Domain (HU 4.2).
abstract interface class TransactionRepository {
  /// Trae una página de transacciones del usuario, ordenadas de más reciente
  /// a más antigua.
  ///
  /// [cursor] es la fecha del último elemento de la página previa; si es null
  /// se trae la primera página.
  Future<Result<TransactionPage>> getTransactionsPage({
    required String userId,
    required int limit,
    DateTime? cursor,
  });

  /// Inserta transacciones de ejemplo (solo para la demo del módulo).
  Future<Result<int>> seedDemoTransactions({required String userId});
}
