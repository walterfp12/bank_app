import 'package:intl/intl.dart';

/// Utilidades para formateo de moneda y fechas
class FormatUtils {
  FormatUtils._();

  /// Formato de moneda (Q para Guatemala / $ para USD)
  static String currency(double amount, {String symbol = 'Q'}) {
    final formatter = NumberFormat.currency(
      locale: 'es_GT',
      symbol: symbol,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Formato de moneda compacto para saldos grandes
  static String currencyCompact(double amount, {String symbol = 'Q'}) {
    if (amount >= 1000000) {
      return '$symbol${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '$symbol${(amount / 1000).toStringAsFixed(1)}K';
    }
    return currency(amount, symbol: symbol);
  }

  /// Formato de fecha completa
  static String dateComplete(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'es').format(date);
  }

  /// Formato de fecha corta
  static String dateShort(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Formato de fecha relativa (hoy, ayer, etc.)
  static String dateRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Ayer, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE, HH:mm', 'es').format(date);
    } else {
      return DateFormat('dd MMM yyyy', 'es').format(date);
    }
  }

  /// Enmascarar número de cuenta (mostrar últimos 4 dígitos)
  static String maskAccountNumber(String number) {
    if (number.length < 4) return number;
    final lastFour = number.substring(number.length - 4);
    return '•••• •••• •••• $lastFour';
  }

  /// Enmascarar número de tarjeta
  static String maskCardNumber(String number) {
    final cleaned = number.replaceAll(' ', '');
    if (cleaned.length < 4) return cleaned;
    final lastFour = cleaned.substring(cleaned.length - 4);
    return '•••• •••• •••• $lastFour';
  }

  /// Formatear número de tarjeta con espacios
  static String formatCardNumber(String number) {
    final cleaned = number.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }
}
