import '../../../../core/errors/result.dart';
import '../entities/dashboard_data.dart';

/// Contrato del repositorio de dashboard — capa Domain.
///
/// La capa Presentation depende de esta abstracción, no de la implementación
/// concreta. Así se puede cambiar el origen de datos (mock hoy, Firebase en M4)
/// sin tocar la UI ni los casos de uso.
abstract interface class DashboardRepository {
  /// Obtiene los datos del dashboard. La implementación decide si vienen
  /// de red, mock o caché local.
  Future<Result<DashboardData>> getDashboardData();
}
