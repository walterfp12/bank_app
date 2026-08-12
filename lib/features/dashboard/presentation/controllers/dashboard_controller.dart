import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';
import '../providers/dashboard_providers.dart';
import '../states/dashboard_state.dart';

/// Controller del dashboard — capa Presentation (Riverpod Notifier).
///
/// Devuelve un [DashboardState] propio (no una lista). Orquesta el caso de uso
/// y traduce el `Result` de Domain en estados de UI: loading → loaded / error.
class DashboardController extends Notifier<DashboardState> {
  GetDashboardDataUseCase get _useCase => ref.read(getDashboardDataUseCaseProvider);

  @override
  DashboardState build() {
    // Carga automática la primera vez que alguien observa el provider.
    _load();
    return const DashboardState.initial();
  }

  /// Recarga manual (pull-to-refresh o botón "Reintentar").
  Future<void> refresh() => _load();

  Future<void> _load() async {
    state = const DashboardState.loading();

    final result = await _useCase();

    result.when(
      success: (data) => state = DashboardState.loaded(data: data),
      failure: (error) =>
          state = DashboardState.error(message: error.friendlyMessage),
    );
  }

}

/// Provider del controller — expone el [DashboardState] a la UI.
final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardState>(
  DashboardController.new,
);
