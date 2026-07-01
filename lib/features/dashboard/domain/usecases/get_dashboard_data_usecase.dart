import '../../../../core/errors/result.dart';
import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

/// Caso de uso: obtener los datos del dashboard — capa Domain.
///
/// Encapsula una única acción de negocio. La Presentation invoca el caso de
/// uso, no el repositorio directamente. Es el punto ideal para añadir reglas
/// (ordenar cuentas, filtrar, etc.) sin ensuciar la UI.
class GetDashboardDataUseCase {
  final DashboardRepository _repository;

  const GetDashboardDataUseCase(this._repository);

  Future<Result<DashboardData>> call() => _repository.getDashboardData();
}
