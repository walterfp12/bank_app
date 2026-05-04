import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../states/auth_state.dart';

/// Controller de autenticación – capa Presentation (Riverpod Notifier)
///
/// Gestiona el ciclo completo:
/// 1. login()             → AuthService → emite loading / authenticated / error
/// 2. logout()            → limpia sesión local → emite initial
/// 3. tryRestoreSession() → restaura sesión persistida al arrancar la app
/// 4. Timer de expiración → a los 2 min el token vence y se ejecuta logout()
///    automáticamente; el RouterNotifier redirige al guard de GoRouter.
class AuthController extends Notifier<AuthState> {
  Timer? _expirationTimer;

  @override
  AuthState build() {
    // Cancelar el timer de expiración cuando el provider se destruya
    ref.onDispose(_cancelExpiration);
    return const AuthState.initial();
  }

  // ─── Acciones ─────────────────────────────────────────────────────────────

  Future<void> login(String username, String password) async {
    state = const AuthState.loading();

    final result = await ref.read(authServiceProvider).login(username, password);

    result.when(
      success: (session) {
        state = AuthState.authenticated(session: session);
        _scheduleExpiration(session.expiresAt);
      },
      failure: (error) => state = AuthState.error(message: error.toString()),
    );
  }

  Future<void> logout() async {
    _cancelExpiration();
    await ref.read(authServiceProvider).logout();
    state = const AuthState.initial();
  }

  Future<void> tryRestoreSession() async {
    state = const AuthState.loading();
    final session =
        await ref.read(sessionServiceProvider).tryRestoreSession();
    if (session != null) {
      state = AuthState.authenticated(session: session);
      _scheduleExpiration(session.expiresAt);
    } else {
      state = const AuthState.initial();
    }
  }

  // ─── Timer de expiración (2 min) ──────────────────────────────────────────

  /// Programa el logout automático cuando el token venza.
  void _scheduleExpiration(DateTime expiresAt) {
    _cancelExpiration();
    final duration = expiresAt.difference(DateTime.now());
    if (duration.isNegative || duration == Duration.zero) {
      logout();
      return;
    }
    _expirationTimer = Timer(duration, logout);
  }

  void _cancelExpiration() {
    _expirationTimer?.cancel();
    _expirationTimer = null;
  }

  // ─── Getters de conveniencia ──────────────────────────────────────────────

  bool get isAuthenticated => state is AuthStateAuthenticated;
}

/// Provider del AuthController – accesible en toda la app
final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
