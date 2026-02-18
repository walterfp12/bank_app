import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar localización para formateo de fechas en español
  await initializeDateFormatting('es', null);

  runApp(const BankApp());
}

/// Aplicación principal BAM Wallet & Transfers
/// HU 1.1 – Punto de entrada con Material 3 y go_router
class BankApp extends StatelessWidget {
  const BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BAM Wallet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
