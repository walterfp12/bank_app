import 'package:flutter/material.dart';

/// Paleta de colores de la aplicación bancaria
class AppColors {
  AppColors._();

  // Colores primarios (Amarillo)
  static const Color primary = Color(0xFFFFCC00); // Amarillo vibrante
  static const Color primaryLight = Color(0xFFFFE066);
  static const Color primaryDark = Color(0xFFC79A00);

  // Colores secundarios (Negro)
  static const Color secondary = Color(0xFF000000);
  static const Color secondaryLight = Color(0xFF2C2C2C);
  static const Color secondaryDark = Color(0xFF000000);

  // Colores de acento
  static const Color accent = Color(0xFF000000); // Negro como acento secundario
  static const Color gold = Color(0xFFD4A847);

  // Colores de fondo
  static const Color background = Color(0xFFF9FAFB); // Blanco grisáceo muy suave para fondo
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Colores de texto
  static const Color textPrimary = Color(0xFF111827); // Negro suave (Cool Gray 900)
  static const Color textSecondary = Color(0xFF4B5563); // Gris oscuro
  static const Color textLight = Color(0xFF9CA3AF); // Gris medio
  static const Color textOnPrimary = Color(0xFF000000); // Texto negro sobre botones amarillos

  // Colores de estado
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  // Colores de ingreso/egreso
  static const Color income = Color(0xFF059669);
  static const Color expense = Color(0xFFDC2626);

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF000000), Color(0xFF2C2C2C), Color(0xFF1A1A1A)], // Tarjeta negra elegante
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
