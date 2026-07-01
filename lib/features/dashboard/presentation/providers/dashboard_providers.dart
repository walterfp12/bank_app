import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/infrastructure_providers.dart';
import '../../data/datasources/dashboard_local_datasource.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';

/// Inyección de dependencias del feature dashboard (Riverpod).
/// Cada capa se conecta con la de abajo mediante abstracciones.

// ─── Data ─────────────────────────────────────────────────────────────────────

final dashboardRemoteDataSourceProvider =
    Provider<DashboardRemoteDataSource>((ref) {
  return const DashboardRemoteDataSourceMock();
});

final dashboardLocalDataSourceProvider =
    Provider<DashboardLocalDataSource>((ref) {
  return DashboardLocalDataSourceImpl(ref.read(sharedPreferencesProvider));
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    remote: ref.read(dashboardRemoteDataSourceProvider),
    local: ref.read(dashboardLocalDataSourceProvider),
  );
});

// ─── Domain – Use Case ──────────────────────────────────────────────────────

final getDashboardDataUseCaseProvider =
    Provider<GetDashboardDataUseCase>((ref) {
  return GetDashboardDataUseCase(ref.read(dashboardRepositoryProvider));
});
