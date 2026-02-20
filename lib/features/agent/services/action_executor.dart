import '../../../features/accounts/models/bank_account.dart';
import '../../../features/transactions/models/transaction.dart';
import '../../../features/cards/models/bank_card.dart';
import '../../../services/mock_data_service.dart';
import '../../../core/utils/format_utils.dart';
import '../models/agent_action.dart';
import '../models/agent_message.dart';

/// Ejecuta las acciones resueltas por el IntentResolver.
/// Interactúa con los servicios de datos y devuelve resultados formateados.
///
/// ARQUITECTURA: Esta capa abstrae la ejecución de acciones.
/// Cuando se conecten APIs/Firebase reales, solo se cambia esta implementación.
class ActionExecutor {
  ActionExecutor._();

  /// Estado de transferencia pendiente (para flujo multi-step)
  static Map<String, dynamic>? _pendingTransfer;

  /// Ejecuta una acción y devuelve un AgentMessage con la respuesta
  static AgentMessage execute(AgentAction action) {
    return switch (action) {
      GreetingAction() => _handleGreeting(),
      HelpAction() => _handleHelp(),
      CheckBalanceAction() => _handleCheckBalance(action),
      CheckTotalBalanceAction() => _handleTotalBalance(),
      ListAccountsAction() => _handleListAccounts(),
      AccountDetailAction() => _handleAccountDetail(action),
      SearchTransactionsAction() => _handleSearchTransactions(action),
      GetRecentTransactionsAction() => _handleRecentTransactions(action),
      InitiateTransferAction() => _handleInitiateTransfer(action),
      ConfirmTransferAction() => _handleConfirmTransfer(),
      CancelTransferAction() => _handleCancelTransfer(),
      ListCardsAction() => _handleListCards(),
      CardDetailAction() => _handleCardDetail(action),
      BlockCardAction() => _handleBlockCard(action),
      ViewProfileAction() => _handleViewProfile(),
      ConfigureNotificationsAction() => _handleNotifications(action),
      ConfigurePushTokenAction() => _handlePushToken(),
      NavigateAction() => _handleNavigation(action),
      SpendingAnalysisAction() => _handleSpendingAnalysis(action),
      SpendingByCategoryAction() => _handleSpendingByCategory(action),
      UnknownAction() => _handleUnknown(action),
    };
  }

  /// Verifica si hay una transferencia pendiente
  static bool get hasPendingTransfer => _pendingTransfer != null;

  // ═══════════════════════════════════════════════════════════════════════════
  // Handlers de acciones
  // ═══════════════════════════════════════════════════════════════════════════

  static AgentMessage _handleGreeting() {
    final user = MockDataService.currentUser;
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = '¡Buenos días';
    } else if (hour < 18) {
      greeting = '¡Buenas tardes';
    } else {
      greeting = '¡Buenas noches';
    }

    return _agentMsg(
      '$greeting, ${user.fullName.split(' ').first}! 👋\n\nSoy tu asistente bancario con IA. Puedo ayudarte con:\n\n'
      '💰 Consultar saldos y cuentas\n'
      '📊 Buscar transacciones\n'
      '💸 Realizar transferencias\n'
      '💳 Gestionar tarjetas\n'
      '⚙️ Configurar tu cuenta\n\n'
      '¿En qué puedo ayudarte?',
      suggestions: [
        const AgentSuggestion(label: '💰 Ver mi saldo', action: 'saldo total'),
        const AgentSuggestion(label: '💸 Transferir', action: 'quiero hacer una transferencia'),
        const AgentSuggestion(label: '📊 Movimientos', action: 'últimas transacciones'),
        const AgentSuggestion(label: '💳 Mis tarjetas', action: 'ver mis tarjetas'),
      ],
    );
  }

  static AgentMessage _handleHelp() {
    return _agentMsg(
      '🤖 **Estas son algunas cosas que puedo hacer por ti:**\n\n'
      '**💰 Saldos:**\n'
      '• "¿Cuánto tengo en total?"\n'
      '• "Saldo de mi cuenta de ahorro"\n\n'
      '**💸 Transferencias:**\n'
      '• "Transferir Q500 a María López"\n'
      '• "Quiero hacer una transferencia"\n\n'
      '**📊 Transacciones:**\n'
      '• "¿Qué le pagué a Netflix este mes?"\n'
      '• "Mis últimos movimientos"\n'
      '• "Gastos en entretenimiento"\n\n'
      '**💳 Tarjetas:**\n'
      '• "Mostrar mis tarjetas"\n'
      '• "Bloquear mi tarjeta"\n\n'
      '**⚙️ Configuración:**\n'
      '• "Configurar notificaciones"\n'
      '• "Ver mi perfil"\n'
      '• "Ir a configuración"\n\n'
      '**📈 Análisis:**\n'
      '• "¿Cuánto he gastado este mes?"\n'
      '• "Análisis de mis gastos"\n\n'
      '¡Solo dime qué necesitas! 🚀',
      suggestions: [
        const AgentSuggestion(label: '💰 Mi saldo', action: 'saldo total'),
        const AgentSuggestion(label: '💸 Transferir', action: 'quiero transferir'),
        const AgentSuggestion(label: '📊 Historial', action: 'últimas transacciones'),
      ],
    );
  }

  static AgentMessage _handleCheckBalance(CheckBalanceAction action) {
    final accounts = MockDataService.accounts;

    if (action.accountId != null) {
      final account = accounts.firstWhere(
        (a) => a.id == action.accountId,
        orElse: () => accounts.first,
      );
      return _agentMsg(
        '💰 **${account.accountName}**\n\n'
        'Saldo: **${FormatUtils.currency(account.balance)}**\n'
        'Disponible: ${FormatUtils.currency(account.availableBalance)}',
        richContent: AgentRichContent(
          type: RichContentType.balanceSummary,
          data: {'accounts': [_accountToMap(account)]},
        ),
      );
    }

    // Mostrar todas las cuentas con saldo
    final buffer = StringBuffer('💰 **Tus saldos:**\n\n');
    for (final acc in accounts) {
      buffer.writeln('${acc.typeIcon} **${acc.accountName}**');
      buffer.writeln('   Saldo: **${FormatUtils.currency(acc.balance)}**');
      buffer.writeln('   Disponible: ${FormatUtils.currency(acc.availableBalance)}\n');
    }

    return _agentMsg(
      buffer.toString(),
      richContent: AgentRichContent(
        type: RichContentType.accountList,
        data: {'accounts': accounts.map(_accountToMap).toList()},
      ),
      suggestions: [
        const AgentSuggestion(label: '📊 Total', action: 'saldo total'),
        const AgentSuggestion(label: '💸 Transferir', action: 'quiero transferir'),
      ],
    );
  }

  static AgentMessage _handleTotalBalance() {
    final total = MockDataService.totalBalance;
    final accounts = MockDataService.accounts;

    final buffer = StringBuffer('💰 **Balance Total: ${FormatUtils.currency(total)}**\n\n');
    buffer.writeln('Desglose por cuenta:\n');
    for (final acc in accounts) {
      buffer.writeln('${acc.typeIcon} ${acc.accountName}: **${FormatUtils.currency(acc.balance)}**');
    }

    return _agentMsg(
      buffer.toString(),
      richContent: AgentRichContent(
        type: RichContentType.balanceSummary,
        data: {
          'totalBalance': total,
          'accounts': accounts.map(_accountToMap).toList(),
        },
      ),
      suggestions: [
        const AgentSuggestion(label: '💸 Transferir', action: 'quiero hacer una transferencia'),
        const AgentSuggestion(label: '📊 Movimientos', action: 'últimas transacciones'),
      ],
    );
  }

  static AgentMessage _handleListAccounts() {
    final accounts = MockDataService.accounts;
    final buffer = StringBuffer('🏦 **Tus cuentas:**\n\n');

    for (final acc in accounts) {
      buffer.writeln('${acc.typeIcon} **${acc.accountName}** (${acc.typeLabel})');
      buffer.writeln('   N° ****${acc.accountNumber.substring(acc.accountNumber.length - 4)}');
      buffer.writeln('   Saldo: **${FormatUtils.currency(acc.balance)}**\n');
    }

    return _agentMsg(
      buffer.toString(),
      richContent: AgentRichContent(
        type: RichContentType.accountList,
        data: {'accounts': accounts.map(_accountToMap).toList()},
      ),
    );
  }

  static AgentMessage _handleAccountDetail(AccountDetailAction action) {
    final account = MockDataService.accounts.firstWhere(
      (a) => a.id == action.accountId,
      orElse: () => MockDataService.accounts.first,
    );

    return _agentMsg(
      '🏦 **Detalle de cuenta:**\n\n'
      '**${account.accountName}** (${account.typeLabel})\n'
      'Número: ****${account.accountNumber.substring(account.accountNumber.length - 4)}\n'
      'Saldo: **${FormatUtils.currency(account.balance)}**\n'
      'Disponible: ${FormatUtils.currency(account.availableBalance)}\n'
      'Moneda: ${account.currency}',
    );
  }

  static AgentMessage _handleSearchTransactions(SearchTransactionsAction action) {
    var transactions = MockDataService.transactions;

    // Filtrar por query (nombre de comercio/servicio)
    if (action.query != null) {
      transactions = transactions.where((t) =>
        t.title.toLowerCase().contains(action.query!) ||
        t.description.toLowerCase().contains(action.query!)
      ).toList();
    }

    // Filtrar por categoría
    if (action.category != null) {
      transactions = transactions.where((t) =>
        t.category?.toLowerCase() == action.category!.toLowerCase()
      ).toList();
    }

    // Filtrar por fecha
    if (action.fromDate != null) {
      transactions = transactions.where((t) => t.date.isAfter(action.fromDate!)).toList();
    }
    if (action.toDate != null) {
      transactions = transactions.where((t) => t.date.isBefore(action.toDate!)).toList();
    }

    if (transactions.isEmpty) {
      return _agentMsg(
        '🔍 No encontré transacciones con esos criterios.\n\n'
        'Intenta con otros filtros o un rango de fechas diferente.',
        suggestions: [
          const AgentSuggestion(label: '📊 Todos', action: 'últimas transacciones'),
          const AgentSuggestion(label: '🔍 Netflix', action: 'pagos a netflix este mes'),
        ],
      );
    }

    final total = transactions.fold<double>(0, (sum, t) => sum + t.amount);
    final buffer = StringBuffer('🔍 **Encontré ${transactions.length} transacción(es):**\n\n');

    for (final t in transactions) {
      final sign = t.isIncome ? '+' : '-';
      buffer.writeln('${t.isIncome ? '🟢' : '🔴'} **${t.title}**');
      buffer.writeln('   $sign${FormatUtils.currency(t.amount)} · ${FormatUtils.dateShort(t.date)}');
      buffer.writeln('   ${t.description}\n');
    }

    buffer.writeln('💵 **Total: ${FormatUtils.currency(total)}**');

    return _agentMsg(
      buffer.toString(),
      richContent: AgentRichContent(
        type: RichContentType.transactionList,
        data: {'transactions': transactions.map(_transactionToMap).toList()},
      ),
    );
  }

  static AgentMessage _handleRecentTransactions(GetRecentTransactionsAction action) {
    final transactions = MockDataService.transactions.take(action.limit).toList();
    final buffer = StringBuffer('📊 **Últimos ${transactions.length} movimientos:**\n\n');

    for (final t in transactions) {
      final sign = t.isIncome ? '+' : '-';
      buffer.writeln('${t.isIncome ? '🟢' : '🔴'} **${t.title}**');
      buffer.writeln('   $sign${FormatUtils.currency(t.amount)} · ${FormatUtils.dateShort(t.date)} · ${t.statusLabel}\n');
    }

    return _agentMsg(
      buffer.toString(),
      richContent: AgentRichContent(
        type: RichContentType.transactionList,
        data: {'transactions': transactions.map(_transactionToMap).toList()},
      ),
      suggestions: [
        const AgentSuggestion(label: '🔍 Buscar', action: 'buscar transacciones'),
        const AgentSuggestion(label: '📈 Análisis', action: 'análisis de gastos'),
      ],
    );
  }

  static AgentMessage _handleInitiateTransfer(InitiateTransferAction action) {
    // Si faltan datos, pedirlos
    if (action.toRecipient == null && action.amount == null) {
      return _agentMsg(
        '💸 **Preparando transferencia**\n\n'
        'Necesito algunos datos:\n'
        '• ¿A quién quieres transferir?\n'
        '• ¿Cuánto quieres enviar?\n\n'
        'Puedes decirme algo como:\n"Transferir Q500 a María López"',
        suggestions: [
          const AgentSuggestion(label: 'Q500 a María', action: 'transferir Q500 a María López'),
          const AgentSuggestion(label: 'Q1,000 a Juan', action: 'transferir Q1000 a Juan Pérez'),
        ],
      );
    }

    final fromAccount = MockDataService.accounts.first;
    final amount = action.amount ?? 0;
    final recipient = action.toRecipient ?? 'Destinatario';

    // Guardar transferencia pendiente
    _pendingTransfer = {
      'fromAccount': fromAccount.accountName,
      'fromAccountId': fromAccount.id,
      'toRecipient': recipient,
      'amount': amount,
      'description': action.description ?? 'Transferencia',
    };

    return _agentMsg(
      '💸 **Confirma tu transferencia:**\n\n'
      '🏦 Desde: **${fromAccount.accountName}**\n'
      '👤 Para: **$recipient**\n'
      '💵 Monto: **${FormatUtils.currency(amount)}**\n'
      '📝 Concepto: ${action.description ?? 'Transferencia'}\n\n'
      '¿Confirmas esta transferencia?',
      type: MessageType.actionConfirmation,
      richContent: AgentRichContent(
        type: RichContentType.transferConfirmation,
        data: _pendingTransfer!,
      ),
      suggestions: [
        const AgentSuggestion(label: '✅ Confirmar', action: 'confirmar'),
        const AgentSuggestion(label: '❌ Cancelar', action: 'cancelar'),
      ],
    );
  }

  static AgentMessage _handleConfirmTransfer() {
    if (_pendingTransfer == null) {
      return _agentMsg(
        '⚠️ No hay ninguna transferencia pendiente para confirmar.\n\n'
        '¿Quieres iniciar una nueva transferencia?',
        suggestions: [
          const AgentSuggestion(label: '💸 Nueva', action: 'quiero hacer una transferencia'),
        ],
      );
    }

    final transfer = _pendingTransfer!;
    _pendingTransfer = null;

    return _agentMsg(
      '✅ **¡Transferencia realizada con éxito!**\n\n'
      '💵 ${FormatUtils.currency(transfer['amount'] as double)} enviados a **${transfer['toRecipient']}**\n'
      '📋 Ref: TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}\n\n'
      '¿Necesitas algo más?',
      type: MessageType.actionResult,
      richContent: AgentRichContent(
        type: RichContentType.transferResult,
        data: {
          ...transfer,
          'status': 'completed',
          'reference': 'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
          'timestamp': DateTime.now().toIso8601String(),
        },
      ),
      suggestions: [
        const AgentSuggestion(label: '💸 Otra transferencia', action: 'quiero transferir'),
        const AgentSuggestion(label: '💰 Ver saldo', action: 'saldo total'),
        const AgentSuggestion(label: '📊 Historial', action: 'últimas transacciones'),
      ],
    );
  }

  static AgentMessage _handleCancelTransfer() {
    _pendingTransfer = null;
    return _agentMsg(
      '❌ Transferencia cancelada.\n\n¿En qué más puedo ayudarte?',
      suggestions: [
        const AgentSuggestion(label: '💰 Ver saldo', action: 'saldo total'),
        const AgentSuggestion(label: '📊 Historial', action: 'últimas transacciones'),
      ],
    );
  }

  static AgentMessage _handleListCards() {
    final cards = MockDataService.cards;
    final buffer = StringBuffer('💳 **Tus tarjetas:**\n\n');

    for (final card in cards) {
      buffer.writeln('${card.brand == CardBrand.visa ? '🔵' : '🟠'} **${card.brandLabel} ${card.typeLabel}**');
      buffer.writeln('   N° ****${card.cardNumber.substring(card.cardNumber.length - 4)}');
      buffer.writeln('   Titular: ${card.holderName}');
      buffer.writeln('   Vence: ${card.expiryDate}');
      if (card.isBlocked) buffer.writeln('   🔒 BLOQUEADA');
      buffer.writeln('');
    }

    return _agentMsg(
      buffer.toString(),
      richContent: AgentRichContent(
        type: RichContentType.cardInfo,
        data: {'cards': cards.map(_cardToMap).toList()},
      ),
      suggestions: [
        const AgentSuggestion(label: '🔒 Bloquear', action: 'bloquear tarjeta'),
        const AgentSuggestion(label: '💰 Saldos', action: 'ver mis saldos'),
      ],
    );
  }

  static AgentMessage _handleCardDetail(CardDetailAction action) {
    final card = MockDataService.cards.firstWhere(
      (c) => c.id == action.cardId,
      orElse: () => MockDataService.cards.first,
    );
    return _agentMsg(
      '💳 **${card.brandLabel} ${card.typeLabel}**\n\n'
      'N° ****${card.cardNumber.substring(card.cardNumber.length - 4)}\n'
      'Titular: ${card.holderName}\n'
      'Vence: ${card.expiryDate}\n'
      'Estado: ${card.isBlocked ? '🔒 Bloqueada' : '✅ Activa'}',
    );
  }

  static AgentMessage _handleBlockCard(BlockCardAction action) {
    return _agentMsg(
      '🔒 **Tarjeta bloqueada temporalmente.**\n\n'
      'Tu tarjeta ha sido bloqueada por seguridad. '
      'Puedes desbloquearla en cualquier momento desde configuración '
      'o diciendo "desbloquear tarjeta".\n\n'
      'Si fue por robo o extravío, te recomendamos contactar a soporte: 📞 1766',
      type: MessageType.actionResult,
    );
  }

  static AgentMessage _handleViewProfile() {
    final user = MockDataService.currentUser;
    return _agentMsg(
      '👤 **Tu perfil:**\n\n'
      '📛 Nombre: **${user.fullName}**\n'
      '✉️ Email: ${user.email}\n'
      '📱 Teléfono: ${user.phone}\n'
      '🆔 DPI: ${user.dpi}\n'
      '📅 Cliente desde: ${FormatUtils.dateShort(user.createdAt)}',
      richContent: AgentRichContent(
        type: RichContentType.userProfile,
        data: user.toJson(),
      ),
    );
  }

  static AgentMessage _handleNotifications(ConfigureNotificationsAction action) {
    return _agentMsg(
      '🔔 **Configuración de notificaciones**\n\n'
      'He activado las notificaciones push para:\n'
      '✅ Transferencias recibidas\n'
      '✅ Transferencias enviadas\n'
      '✅ Pagos con tarjeta\n'
      '✅ Alertas de seguridad\n\n'
      'Puedes personalizar qué notificaciones recibir desde ⚙️ Configuración.',
      type: MessageType.actionResult,
      suggestions: [
        const AgentSuggestion(label: '⚙️ Config', action: 'ir a configuración'),
      ],
    );
  }

  static AgentMessage _handlePushToken() {
    final token = 'fcm_${DateTime.now().millisecondsSinceEpoch}_bam_wallet';
    return _agentMsg(
      '🔧 **Push Token configurado:**\n\n'
      '```\n$token\n```\n\n'
      '✅ Token registrado exitosamente.\n'
      'Las notificaciones push están ahora habilitadas en este dispositivo.',
      type: MessageType.actionResult,
    );
  }

  static AgentMessage _handleNavigation(NavigateAction action) {
    final routeNames = {
      '/dashboard': 'Inicio',
      '/transfers': 'Transferencias',
      '/history': 'Historial',
      '/settings': 'Configuración',
    };
    final name = routeNames[action.route] ?? action.route;
    return _agentMsg(
      '🧭 Navegando a **$name**...',
      type: MessageType.actionResult,
      metadata: {'navigate': action.route},
    );
  }

  static AgentMessage _handleSpendingAnalysis(SpendingAnalysisAction action) {
    final transactions = MockDataService.transactions
        .where((t) => t.isExpense)
        .toList();

    final totalSpent = transactions.fold<double>(0, (sum, t) => sum + t.amount);

    // Agrupar por categoría
    final byCategory = <String, double>{};
    for (final t in transactions) {
      final cat = t.category ?? 'Sin categoría';
      byCategory[cat] = (byCategory[cat] ?? 0) + t.amount;
    }

    final buffer = StringBuffer('📈 **Análisis de gastos:**\n\n');
    buffer.writeln('💵 Total gastado: **${FormatUtils.currency(totalSpent)}**\n');
    buffer.writeln('📊 **Por categoría:**\n');

    final sortedCategories = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sortedCategories) {
      final pct = (entry.value / totalSpent * 100).toStringAsFixed(1);
      buffer.writeln('• ${entry.key}: **${FormatUtils.currency(entry.value)}** ($pct%)');
    }

    buffer.writeln('\n💡 **Tip:** Tu mayor gasto es en **${sortedCategories.first.key}**.');

    return _agentMsg(
      buffer.toString(),
      suggestions: [
        AgentSuggestion(label: '📊 ${sortedCategories.first.key}', action: 'gastos en ${sortedCategories.first.key.toLowerCase()}'),
        const AgentSuggestion(label: '💰 Saldo', action: 'saldo total'),
      ],
    );
  }

  static AgentMessage _handleSpendingByCategory(SpendingByCategoryAction action) {
    final transactions = MockDataService.transactions
        .where((t) => t.isExpense && (t.category?.toLowerCase().contains(action.category) ?? false))
        .toList();

    if (transactions.isEmpty) {
      return _agentMsg(
        '🔍 No encontré gastos en la categoría "${action.category}" en el período seleccionado.',
      );
    }

    final total = transactions.fold<double>(0, (sum, t) => sum + t.amount);
    final buffer = StringBuffer('📊 **Gastos en ${action.category}:**\n\n');

    for (final t in transactions) {
      buffer.writeln('🔴 ${t.title}: **${FormatUtils.currency(t.amount)}**');
      buffer.writeln('   ${FormatUtils.dateShort(t.date)} · ${t.description}\n');
    }

    buffer.writeln('💵 **Total: ${FormatUtils.currency(total)}** en ${transactions.length} transacción(es)');

    return _agentMsg(buffer.toString());
  }

  static AgentMessage _handleUnknown(UnknownAction action) {
    return _agentMsg(
      '🤔 No estoy seguro de entender "${action.originalMessage}".\n\n'
      'Puedo ayudarte con saldos, transferencias, historial, tarjetas y más. '
      '¿Podrías reformular tu solicitud?',
      suggestions: [
        const AgentSuggestion(label: '❓ Ayuda', action: 'ayuda'),
        const AgentSuggestion(label: '💰 Saldo', action: 'saldo total'),
        const AgentSuggestion(label: '💸 Transferir', action: 'quiero transferir'),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Helpers
  // ═══════════════════════════════════════════════════════════════════════════

  static int _msgCounter = 0;

  static AgentMessage _agentMsg(
    String text, {
    MessageType type = MessageType.text,
    AgentRichContent? richContent,
    List<AgentSuggestion>? suggestions,
    Map<String, dynamic>? metadata,
  }) {
    _msgCounter++;
    return AgentMessage(
      id: 'agent_${DateTime.now().millisecondsSinceEpoch}_$_msgCounter',
      text: text,
      sender: MessageSender.agent,
      type: type,
      timestamp: DateTime.now(),
      richContent: richContent,
      suggestions: suggestions,
      metadata: metadata,
    );
  }

  static Map<String, dynamic> _accountToMap(BankAccount acc) => {
    'id': acc.id,
    'name': acc.accountName,
    'type': acc.typeLabel,
    'balance': acc.balance,
    'available': acc.availableBalance,
    'number': acc.accountNumber,
  };

  static Map<String, dynamic> _transactionToMap(Transaction t) => {
    'id': t.id,
    'title': t.title,
    'description': t.description,
    'amount': t.amount,
    'type': t.type.name,
    'status': t.status.name,
    'date': t.date.toIso8601String(),
    'isIncome': t.isIncome,
  };

  static Map<String, dynamic> _cardToMap(BankCard c) => {
    'id': c.id,
    'number': c.cardNumber,
    'holder': c.holderName,
    'expiry': c.expiryDate,
    'type': c.typeLabel,
    'brand': c.brandLabel,
    'isBlocked': c.isBlocked,
  };
}
