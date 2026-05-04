import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../states/auth_state.dart';

/// Rutas que requieren sesión activa
const _protectedRoutes = {
  '/dashboard',
  '/transfers',
  '/history',
  '/settings',
  '/agent',
};

/// Puente entre Riverpod y GoRouter.
/// Extiende ChangeNotifier para que GoRouter escuche cambios de AuthState
/// vía refreshListenable.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  late final ProviderSubscription<AuthState> subscription;

  RouterNotifier(this._ref) {
    // Escucha cambios de AuthController y notifica al GoRouter
    subscription = _ref.listen<AuthState>(
      authControllerProvider,
      (prev, next) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    subscription.close();
    super.dispose();
  }

  /// Guard de rutas: HU 2.3
  String? redirect(BuildContext context, GoRouterState routerState) {
    final authState = _ref.read(authControllerProvider);
    final location  = routerState.matchedLocation;

    return authState.when(
      initial: () =>
          _protectedRoutes.contains(location) ? '/login' : null,

      // Durante carga no redirigir (evita flash)
      loading: () => null,

      authenticated: (_) =>
          location == '/login' ? '/dashboard' : null,

      error: (_) =>
          _protectedRoutes.contains(location) ? '/login' : null,
    );
  }
}

/// Provider del RouterNotifier – keepAlive para que no se destruya
final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});
