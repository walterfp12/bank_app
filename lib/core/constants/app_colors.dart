import 'package:flutter/material.dart';

/// Paleta de colores de la aplicación bancaria
class AppColors {
  AppColors._();

  // Colores primarios
  static const Color primary = Color(0xFF1A3C6E);
  static const Color primaryLight = Color(0xFF2E5EA8);
  static const Color primaryDark = Color(0xFF0D1F3C);

  // Colores secundarios
  static const Color secondary = Color(0xFF00B4D8);
  static const Color secondaryLight = Color(0xFF48CAE4);
  static const Color secondaryDark = Color(0xFF0077B6);

  // Colores de acento
  static const Color accent = Color(0xFFF4A261);
  static const Color gold = Color(0xFFD4A847);

  // Colores de fondo
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F2F5);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Colores de texto
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Colores de estado
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Colores de ingreso/egreso
  static const Color income = Color(0xFF10B981);
  static const Color expense = Color(0xFFEF4444);

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A3C6E), Color(0xFF2E5EA8), Color(0xFF0077B6)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD4A847), Color(0xFFF4D03F), Color(0xFFD4A847)],
  );

  // Sombras
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}
