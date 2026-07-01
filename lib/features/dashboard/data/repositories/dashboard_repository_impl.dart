import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_datasource.dart';
import '../datasources/dashboard_remote_datasource.dart';

/// Implementación del repositorio de dashboard — capa Data.
///
/// Estrategia de caché (HU 3.2):
/// 1. Intenta obtener datos frescos del DataSource remoto (mock).
/// 2. Si tiene éxito → los guarda en caché local y los devuelve.
/// 3. Si falla → intenta devolver la última caché disponible (modo offline).
/// 4. Si tampoco hay caché → propaga el error para que la UI muestre el estado
///    de error.
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remote;
  final DashboardLocalDataSource _local;

  const DashboardRepositoryImpl({
    required DashboardRemoteDataSource remote,
    required DashboardLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  @override
  Future<Result<DashboardData>> getDashboardData() async {
    try {
      final fresh = await _remote.fetchDashboard();
      await _local.cacheDashboard(fresh);
      return Result.success(fresh.toDomain());
    } on Exception catch (e) {
      // Falla la red: intentamos caché local.
      final cached = _local.readCachedDashboard();
      if (cached != null) {
        return Result.success(cached.toDomain());
      }
      return Result.failure(
        e is AppException ? e : NetworkException(originalError: e),
      );
    }
  }
}
