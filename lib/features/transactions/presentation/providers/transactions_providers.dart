import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/infrastructure_providers.dart';
import '../../data/datasources/transaction_remote_datasource.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/get_transactions_page_usecase.dart';
import '../../domain/usecases/seed_transactions_usecase.dart';

/// Inyección de dependencias del feature transactions (HU 4.2).

// ─── Data ─────────────────────────────────────────────────────────────────────

final transactionRemoteDataSourceProvider =
    Provider<TransactionRemoteDataSource>((ref) {
  return TransactionFirestoreDataSource(ref.read(firestoreProvider));
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    ref.read(transactionRemoteDataSourceProvider),
  );
});

// ─── Domain – Use Cases ───────────────────────────────────────────────────────

final getTransactionsPageUseCaseProvider =
    Provider<GetTransactionsPageUseCase>((ref) {
  return GetTransactionsPageUseCase(ref.read(transactionRepositoryProvider));
});

final seedTransactionsUseCaseProvider = Provider<SeedTransactionsUseCase>((ref) {
  return SeedTransactionsUseCase(ref.read(transactionRepositoryProvider));
});
