import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/providers/infrastructure_providers.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'routes/app_router.dart';

/// Punto de entrada – BAM Wallet & Transfers
/// HU 1.1 – Material 3 + go_router
/// HU 2.3 – Riverpod ProviderScope con override de SharedPreferences
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);

  // Inicializar SharedPreferences antes de crear el ProviderScope
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Inyección de SharedPreferences real (override del provider base)
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const BankApp(),
    ),
  );
}

/// Aplicación principal – ConsumerStatefulWidget para restaurar sesión al arrancar.
class BankApp extends ConsumerStatefulWidget {
  const BankApp({super.key});

  @override
  ConsumerState<BankApp> createState() => _BankAppState();
}

class _BankAppState extends ConsumerState<BankApp> {
  @override
  void initState() {
    super.initState();
    // Restaurar sesión persistida ANTES del primer frame
    // (si hay sesión válida → GoRouter navega directo a /dashboard)
    Future.microtask(
      () => ref.read(authControllerProvider.notifier).tryRestoreSession(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title:                    'BAM Wallet',
      debugShowCheckedModeBanner: false,
      theme:                    AppTheme.lightTheme,
      routerConfig:             router,
    );
  }
}
