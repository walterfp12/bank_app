import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dashboard_data.dart';

part 'dashboard_state.freezed.dart';

/// Estado de la pantalla de dashboard — capa Presentation (Freezed sealed).
///
/// El Notifier NO devuelve `List<Account>` ni nada suelto: devuelve SIEMPRE una
/// de estas 4 variantes. Así la UI hace pattern matching exhaustivo y no puede
/// olvidar los estados de carga o error.
@freezed
sealed class DashboardState with _$DashboardState {
  /// Aún no se ha pedido nada.
  const factory DashboardState.initial() = DashboardInitial;

  /// Cargando datos (muestra spinner).
  const factory DashboardState.loading() = DashboardLoading;

  /// Datos disponibles. [fromCache] indica si vienen de la caché offline.
  const factory DashboardState.loaded({
    required DashboardData data,
    @Default(false) bool fromCache,
  }) = DashboardLoaded;

  /// Error al cargar (muestra mensaje + botón reintentar).
  const factory DashboardState.error({required String message}) =
      DashboardError;
}
