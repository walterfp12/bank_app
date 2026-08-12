import '../../../../core/errors/result.dart';
import '../entities/transaction_page.dart';
import '../repositories/transaction_repository.dart';

/// Caso de uso: obtener una página del historial – capa Domain (HU 4.2).
///
/// Encapsula la regla de negocio del tamaño de página, para que ni la UI ni el
/// repositorio decidan cuántos registros traer.
class GetTransactionsPageUseCase {
  final TransactionRepository _repository;

  const GetTransactionsPageUseCase(this._repository);

  /// Cantidad de movimientos por página.
  static const pageSize = 10;

  Future<Result<TransactionPage>> call({
    required String userId,
    DateTime? cursor,
  }) {
    return _repository.getTransactionsPage(
      userId: userId,
      limit: pageSize,
      cursor: cursor,
    );
  }
}
