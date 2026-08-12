import '../../../../core/errors/result.dart';
import '../repositories/transaction_repository.dart';

/// Caso de uso: sembrar transacciones de demostración – capa Domain.
///
/// Solo se usa desde el botón de debug para poblar Firestore y poder demostrar
/// el paginado con datos reales.
class SeedTransactionsUseCase {
  final TransactionRepository _repository;

  const SeedTransactionsUseCase(this._repository);

  Future<Result<int>> call({required String userId}) =>
      _repository.seedDemoTransactions(userId: userId);
}
