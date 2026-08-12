import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/router_notifier.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/transactions/screens/transfers_screen.dart';
import '../features/transactions/presentation/screens/history_screen.dart';
import '../features/profile/screens/settings_screen.dart';
import '../features/agent/screens/agent_chat_screen.dart';
import '../features/notifications/presentation/screens/notifications_screen.dart';
import 'app_shell.dart';

/// HU 1.2 – Navegación de la aplicación con GoRouter
/// HU 2.3 – Guard de rutas reactivo (refreshListenable → RouterNotifier → Riverpod)
///
/// El GoRouter escucha a RouterNotifier (ChangeNotifier).
/// RouterNotifier escucha AuthController (Riverpod).
/// Al cambiar el estado de auth → notifyListeners() → GoRouter re-evalúa redirect.
final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(routerNotifierProvider);

  return GoRouter(
    initialLocation:    '/login',
    debugLogDiagnostics: true,
    refreshListenable:  notifier,
    redirect:           notifier.redirect,

    routes: [
      // ── Rutas públicas ────────────────────────────────────────────────────
      GoRoute(
        path:    '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // ── Agente IA (pantalla completa) ─────────────────────────────────────
      GoRoute(
        path:    '/agent',
        builder: (context, state) => const AgentChatScreen(),
      ),

      // ── Notificaciones push – HU 4.3 ──────────────────────────────────────
      GoRoute(
        path:    '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),

      // ── Shell con BottomNavigationBar ─────────────────────────────────────
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path:        '/dashboard',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardScreen()),
          ),
          GoRoute(
            path:        '/transfers',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TransfersScreen()),
          ),
          GoRoute(
            path:        '/history',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HistoryScreen()),
          ),
          GoRoute(
            path:        '/settings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
    ],
  );
});

final _shellNavigatorKey = GlobalKey<NavigatorState>();
