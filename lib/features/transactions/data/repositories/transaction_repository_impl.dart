import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/transaction_page.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_datasource.dart';

/// Implementación del repositorio de transacciones – capa Data (HU 4.2).
///
/// Convierte modelos a entidades, calcula el cursor de la siguiente página y
/// traduce los errores de Firestore a excepciones del dominio.
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource _remote;

  const TransactionRepositoryImpl(this._remote);

  @override
  Future<Result<TransactionPage>> getTransactionsPage({
    required String userId,
    required int limit,
    DateTime? cursor,
  }) async {
    try {
      final result = await _remote.fetchPage(
        userId: userId,
        limit: limit,
        cursor: cursor,
      );

      final items = result.items.map((m) => m.toDomain()).toList();

      return Result.success(
        TransactionPage(
          items: items,
          hasMore: result.hasMore,
          // El cursor de la siguiente página es la fecha del último elemento.
          nextCursor: result.hasMore && items.isNotEmpty ? items.last.date : null,
        ),
      );
    } on FirebaseException catch (e) {
      return Result.failure(_mapFirestoreError(e));
    } on Exception catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  @override
  Future<Result<int>> seedDemoTransactions({required String userId}) async {
    try {
      return Result.success(await _remote.seedDemoTransactions(userId: userId));
    } on FirebaseException catch (e) {
      return Result.failure(_mapFirestoreError(e));
    } on Exception catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  AppException _mapFirestoreError(FirebaseException e) {
    return switch (e.code) {
      'permission-denied' => const ForbiddenException(
          message: 'No tienes permisos para consultar el historial.',
        ),
      'unavailable' => const NetworkException(),
      'deadline-exceeded' => const RequestTimeoutException(),
      _ => UnknownException(
          message: e.message ?? 'Error al consultar Firestore.',
          originalError: e,
        ),
    };
  }
}
