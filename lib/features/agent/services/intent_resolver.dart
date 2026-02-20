import '../models/agent_action.dart';

/// Resuelve la intención del usuario a partir de texto natural.
/// 
/// ARQUITECTURA: Este resolver usa pattern matching local.
/// Está diseñado para ser reemplazable por un LLM (OpenAI, Gemini, etc.)
/// sin cambiar la interfaz. Solo se reemplaza la implementación interna.
class IntentResolver {
  IntentResolver._();

  /// Resuelve un texto del usuario en una [AgentAction]
  static AgentAction resolve(String input) {
    final text = input.toLowerCase().trim();

    // ─── Saludos ─────────────────────────────────────────────────────────
    if (_matchesAny(text, _greetingPatterns)) {
      return const GreetingAction();
    }

    // ─── Ayuda ───────────────────────────────────────────────────────────
    if (_matchesAny(text, _helpPatterns)) {
      return const HelpAction();
    }

    // ─── Transferencias ──────────────────────────────────────────────────
    if (_matchesAny(text, _transferPatterns)) {
      return _parseTransferIntent(text);
    }

    // ─── Confirmación de transferencia ───────────────────────────────────
    if (_matchesAny(text, _confirmPatterns)) {
      return const ConfirmTransferAction(transferId: 'pending');
    }

    // ─── Cancelar ────────────────────────────────────────────────────────
    if (_matchesAny(text, _cancelPatterns)) {
      return const CancelTransferAction();
    }

    // ─── Saldo total ─────────────────────────────────────────────────────
    if (_matchesAny(text, _totalBalancePatterns)) {
      return const CheckTotalBalanceAction();
    }

    // ─── Saldo de cuenta específica ──────────────────────────────────────
    if (_matchesAny(text, _balancePatterns)) {
      return const CheckBalanceAction();
    }

    // ─── Búsqueda de transacciones ───────────────────────────────────────
    if (_matchesAny(text, _transactionSearchPatterns)) {
      return _parseTransactionSearch(text);
    }

    // ─── Transacciones recientes ─────────────────────────────────────────
    if (_matchesAny(text, _recentTransactionsPatterns)) {
      return const GetRecentTransactionsAction();
    }

    // ─── Cuentas ─────────────────────────────────────────────────────────
    if (_matchesAny(text, _accountPatterns)) {
      return const ListAccountsAction();
    }

    // ─── Tarjetas ────────────────────────────────────────────────────────
    if (_matchesAny(text, _cardPatterns)) {
      return const ListCardsAction();
    }

    // ─── Bloquear tarjeta ────────────────────────────────────────────────
    if (_matchesAny(text, _blockCardPatterns)) {
      return const BlockCardAction(cardId: 'card_001');
    }

    // ─── Perfil ──────────────────────────────────────────────────────────
    if (_matchesAny(text, _profilePatterns)) {
      return const ViewProfileAction();
    }

    // ─── Notificaciones / Push ───────────────────────────────────────────
    if (_matchesAny(text, _notificationPatterns)) {
      return const ConfigureNotificationsAction();
    }

    if (_matchesAny(text, _pushTokenPatterns)) {
      return const ConfigurePushTokenAction();
    }

    // ─── Análisis de gastos ──────────────────────────────────────────────
    if (_matchesAny(text, _spendingAnalysisPatterns)) {
      return _parseSpendingAnalysis(text);
    }

    // ─── Navegación directa ──────────────────────────────────────────────
    if (_matchesAny(text, _navDashboardPatterns)) {
      return const NavigateAction(route: '/dashboard');
    }
    if (_matchesAny(text, _navTransferPatterns)) {
      return const NavigateAction(route: '/transfers');
    }
    if (_matchesAny(text, _navHistoryPatterns)) {
      return const NavigateAction(route: '/history');
    }
    if (_matchesAny(text, _navSettingsPatterns)) {
      return const NavigateAction(route: '/settings');
    }

    // ─── No reconocido ──────────────────────────────────────────────────
    return UnknownAction(originalMessage: input);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Pattern matching helpers
  // ═══════════════════════════════════════════════════════════════════════════

  static bool _matchesAny(String text, List<String> patterns) {
    return patterns.any((p) => text.contains(p));
  }

  // ─── Parseo de transferencia ───────────────────────────────────────────

  static AgentAction _parseTransferIntent(String text) {
    double? amount;
    String? recipient;
    String? description;

    // Extraer monto: "Q 500", "500 quetzales", "Q500", "1000"
    final amountRegex = RegExp(r'q\s*(\d+[\d,]*\.?\d*)|(\d+[\d,]*\.?\d*)\s*quetzales?|(\d+[\d,]*\.?\d*)', caseSensitive: false);
    final amountMatch = amountRegex.firstMatch(text);
    if (amountMatch != null) {
      final raw = amountMatch.group(1) ?? amountMatch.group(2) ?? amountMatch.group(3);
      if (raw != null) {
        amount = double.tryParse(raw.replaceAll(',', ''));
      }
    }

    // Extraer destinatario: "a María", "a Juan Pérez"
    final recipientRegex = RegExp(r'(?:a|para)\s+([A-ZÁÉÍÓÚÑ][a-záéíóúñ]+(?:\s+[A-ZÁÉÍÓÚÑ][a-záéíóúñ]+)*)');
    final recipientMatch = recipientRegex.firstMatch(text);
    if (recipientMatch != null) {
      recipient = recipientMatch.group(1);
    }

    // Extraer descripción: "por concepto de...", "concepto..."
    final descRegex = RegExp(r'(?:por concepto de|concepto|por|para)\s+(.+?)(?:\s*$)');
    final descMatch = descRegex.firstMatch(text);
    if (descMatch != null && recipient == null) {
      description = descMatch.group(1);
    }

    return InitiateTransferAction(
      amount: amount,
      toRecipient: recipient,
      description: description,
    );
  }

  // ─── Parseo de búsqueda de transacciones ───────────────────────────────

  static AgentAction _parseTransactionSearch(String text) {
    String? query;
    String? category;
    DateTime? fromDate;
    DateTime? toDate;

    // Detectar servicios/comercios: "netflix", "spotify", "uber", etc.
    final services = ['netflix', 'spotify', 'uber', 'rappi', 'empagua', 'la torre', 'eegsa'];
    for (final service in services) {
      if (text.contains(service)) {
        query = service;
        break;
      }
    }

    // Detectar categorías
    final categories = {
      'comida': 'Alimentación', 'alimentación': 'Alimentación', 'supermercado': 'Alimentación',
      'entretenimiento': 'Entretenimiento', 'suscripción': 'Entretenimiento', 'suscripciones': 'Entretenimiento',
      'servicios': 'Servicios', 'agua': 'Servicios', 'luz': 'Servicios',
      'vivienda': 'Vivienda', 'alquiler': 'Vivienda', 'renta': 'Vivienda',
      'efectivo': 'Efectivo', 'retiro': 'Efectivo',
      'salario': 'Salario', 'nómina': 'Salario',
    };
    for (final entry in categories.entries) {
      if (text.contains(entry.key)) {
        category = entry.value;
        break;
      }
    }

    // Detectar rangos de fecha
    final now = DateTime.now();
    if (text.contains('último mes') || text.contains('mes pasado') || text.contains('este mes')) {
      fromDate = DateTime(now.year, now.month - 1, now.day);
      toDate = now;
    } else if (text.contains('última semana') || text.contains('semana pasada') || text.contains('esta semana')) {
      fromDate = now.subtract(const Duration(days: 7));
      toDate = now;
    } else if (text.contains('hoy')) {
      fromDate = DateTime(now.year, now.month, now.day);
      toDate = now;
    } else if (text.contains('ayer')) {
      fromDate = DateTime(now.year, now.month, now.day - 1);
      toDate = DateTime(now.year, now.month, now.day);
    } else if (text.contains('últimos 3 meses') || text.contains('tres meses')) {
      fromDate = DateTime(now.year, now.month - 3, now.day);
      toDate = now;
    } else if (text.contains('este año') || text.contains('último año')) {
      fromDate = DateTime(now.year, 1, 1);
      toDate = now;
    }

    return SearchTransactionsAction(
      query: query,
      category: category,
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  // ─── Parseo de análisis de gastos ──────────────────────────────────────

  static AgentAction _parseSpendingAnalysis(String text) {
    final now = DateTime.now();

    // Detectar categoría específica
    final categories = ['entretenimiento', 'comida', 'servicios', 'vivienda', 'efectivo', 'transporte'];
    for (final cat in categories) {
      if (text.contains(cat)) {
        return SpendingByCategoryAction(
          category: cat,
          fromDate: DateTime(now.year, now.month - 1, 1),
          toDate: now,
        );
      }
    }

    return SpendingAnalysisAction(
      fromDate: DateTime(now.year, now.month - 1, 1),
      toDate: now,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Patrones de detección de intención
  // ═══════════════════════════════════════════════════════════════════════════

  static const _greetingPatterns = [
    'hola', 'buenos días', 'buenas tardes', 'buenas noches', 'qué tal',
    'hey', 'hi', 'hello', 'saludos', 'buenas',
  ];

  static const _helpPatterns = [
    'ayuda', 'qué puedes hacer', 'que puedes hacer', 'opciones', 'comandos',
    'funciones', 'help', 'cómo funciona', 'como funciona', 'qué sabes hacer',
    'que sabes hacer', 'instrucciones',
  ];

  static const _transferPatterns = [
    'transferir', 'transferencia', 'enviar dinero', 'enviar plata',
    'mandar dinero', 'mandar plata', 'pagar a', 'hacer pago',
    'envía', 'transfiere', 'manda',
  ];

  static const _confirmPatterns = [
    'confirmar', 'confirmo', 'sí, confirmo', 'acepto', 'dale',
    'procede', 'hazlo', 'sí', 'si', 'ok', 'adelante',
  ];

  static const _cancelPatterns = [
    'cancelar', 'cancela', 'no, cancelar', 'olvídalo', 'olvidalo',
    'no quiero', 'detener', 'para',
  ];

  static const _totalBalancePatterns = [
    'saldo total', 'balance total', 'cuánto tengo en total',
    'cuanto tengo en total', 'todo mi dinero', 'balance general',
    'cuánto dinero tengo', 'cuanto dinero tengo',
  ];

  static const _balancePatterns = [
    'saldo', 'balance', 'cuánto tengo', 'cuanto tengo',
    'disponible', 'cuánto hay', 'cuanto hay',
  ];

  static const _transactionSearchPatterns = [
    'pagos a', 'pagos de', 'buscar transacción', 'buscar transaccion',
    'gastos en', 'gastos de', 'cobros de', 'cargos de',
    'qué le pagué', 'que le pague', 'cuánto le pagué', 'cuanto le pague',
    'qué pagué', 'que pague', 'buscar pago', 'mostrar pagos',
  ];

  static const _recentTransactionsPatterns = [
    'transacciones recientes', 'últimas transacciones', 'ultimas transacciones',
    'últimos movimientos', 'ultimos movimientos', 'movimientos recientes',
    'historial reciente', 'qué movimientos', 'que movimientos',
  ];

  static const _accountPatterns = [
    'mis cuentas', 'ver cuentas', 'listar cuentas', 'mostrar cuentas',
    'qué cuentas tengo', 'que cuentas tengo', 'información de cuentas',
    'informacion de cuentas',
  ];

  static const _cardPatterns = [
    'mis tarjetas', 'ver tarjetas', 'listar tarjetas', 'mostrar tarjetas',
    'qué tarjetas tengo', 'que tarjetas tengo', 'información de tarjetas',
    'informacion de tarjetas',
  ];

  static const _blockCardPatterns = [
    'bloquear tarjeta', 'bloquea mi tarjeta', 'desactivar tarjeta',
    'reportar tarjeta', 'tarjeta robada', 'tarjeta perdida',
  ];

  static const _profilePatterns = [
    'mi perfil', 'mis datos', 'información personal', 'informacion personal',
    'quién soy', 'quien soy', 'ver perfil', 'datos personales',
  ];

  static const _notificationPatterns = [
    'notificaciones', 'configurar notificaciones', 'activar notificaciones',
    'desactivar notificaciones', 'alertas',
  ];

  static const _pushTokenPatterns = [
    'push token', 'token push', 'configurar push', 'push notification',
    'token de notificación', 'token de notificacion',
  ];

  static const _spendingAnalysisPatterns = [
    'análisis de gastos', 'analisis de gastos', 'resumen de gastos',
    'cuánto he gastado', 'cuanto he gastado', 'desglose de gastos',
    'en qué gasto', 'en que gasto', 'mis gastos',
  ];

  static const _navDashboardPatterns = [
    'ir a inicio', 'ir al dashboard', 'llévame a inicio', 'llevame a inicio',
    'abre el inicio', 'ir a home',
  ];

  static const _navTransferPatterns = [
    'ir a transferencias', 'llévame a transferencias', 'llevame a transferencias',
    'abre transferencias', 'pantalla de transferencia',
  ];

  static const _navHistoryPatterns = [
    'ir a historial', 'llévame al historial', 'llevame al historial',
    'abre el historial', 'pantalla de historial',
  ];

  static const _navSettingsPatterns = [
    'ir a configuración', 'ir a configuracion', 'ir a ajustes',
    'llévame a configuración', 'llevame a configuracion',
    'abre configuración', 'abre configuracion',
  ];
}
