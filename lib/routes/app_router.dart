import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/dashboard_screen.dart';
import '../features/transactions/screens/transfers_screen.dart';
import '../features/transactions/screens/history_screen.dart';
import '../features/profile/screens/settings_screen.dart';
import 'app_shell.dart';

/// HU 1.2 – Sistema de navegación de la aplicación
/// HU 2.3 – Preparado para guard de rutas (redirect)
///
/// Rutas principales:
/// /login        → Pantalla de login
/// /dashboard    → Dashboard principal (tab 0)
/// /transfers    → Transferencias (tab 1)
/// /history      → Historial (tab 2)
/// /settings     → Configuración (tab 3)

class AppRouter {
  AppRouter._();

  // TODO: HU 2.3 – Reemplazar con estado real de autenticación
  static bool _isAuthenticated = false;

  /// Marcar usuario como autenticado (temporal hasta HU 2.3)
  static void setAuthenticated(bool value) {
    _isAuthenticated = value;
  }

  // Keys para navegación anidada
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,

    // HU 2.3 – Guard de rutas: redirigir si no autenticado
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';

      if (!_isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (_isAuthenticated && isLoggingIn) {
        return '/dashboard';
      }

      return null;
    },

    routes: [
      // Login (fuera del shell, sin BottomNav)
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Shell con BottomNavigationBar
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: '/transfers',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TransfersScreen(),
            ),
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HistoryScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
