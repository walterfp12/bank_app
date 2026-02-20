/// Acciones que el agente IA puede ejecutar
/// Cada acción representa una intención del usuario reconocida

sealed class AgentAction {
  const AgentAction();
}

// ─── Consultas de saldos ───────────────────────────────────────────────────

class CheckBalanceAction extends AgentAction {
  final String? accountId;
  const CheckBalanceAction({this.accountId});
}

class CheckTotalBalanceAction extends AgentAction {
  const CheckTotalBalanceAction();
}

// ─── Consultas de transacciones ────────────────────────────────────────────

class SearchTransactionsAction extends AgentAction {
  final String? query;
  final String? category;
  final String? recipientName;
  final DateTime? fromDate;
  final DateTime? toDate;
  final TransactionFilter? filter;

  const SearchTransactionsAction({
    this.query,
    this.category,
    this.recipientName,
    this.fromDate,
    this.toDate,
    this.filter,
  });
}

enum TransactionFilter { all, income, expense, pending }

class GetRecentTransactionsAction extends AgentAction {
  final int limit;
  const GetRecentTransactionsAction({this.limit = 5});
}

// ─── Transferencias ────────────────────────────────────────────────────────

class InitiateTransferAction extends AgentAction {
  final String? fromAccountId;
  final String? toRecipient;
  final double? amount;
  final String? description;

  const InitiateTransferAction({
    this.fromAccountId,
    this.toRecipient,
    this.amount,
    this.description,
  });
}

class ConfirmTransferAction extends AgentAction {
  final String transferId;
  const ConfirmTransferAction({required this.transferId});
}

class CancelTransferAction extends AgentAction {
  const CancelTransferAction();
}

// ─── Consultas de cuentas ──────────────────────────────────────────────────

class ListAccountsAction extends AgentAction {
  const ListAccountsAction();
}

class AccountDetailAction extends AgentAction {
  final String accountId;
  const AccountDetailAction({required this.accountId});
}

// ─── Consultas de tarjetas ─────────────────────────────────────────────────

class ListCardsAction extends AgentAction {
  const ListCardsAction();
}

class CardDetailAction extends AgentAction {
  final String cardId;
  const CardDetailAction({required this.cardId});
}

class BlockCardAction extends AgentAction {
  final String cardId;
  const BlockCardAction({required this.cardId});
}

// ─── Perfil y configuración ────────────────────────────────────────────────

class ViewProfileAction extends AgentAction {
  const ViewProfileAction();
}

class ConfigureNotificationsAction extends AgentAction {
  final bool? enabled;
  const ConfigureNotificationsAction({this.enabled});
}

class ConfigurePushTokenAction extends AgentAction {
  const ConfigurePushTokenAction();
}

// ─── Navegación ────────────────────────────────────────────────────────────

class NavigateAction extends AgentAction {
  final String route;
  const NavigateAction({required this.route});
}

// ─── Ayuda / General ───────────────────────────────────────────────────────

class HelpAction extends AgentAction {
  const HelpAction();
}

class GreetingAction extends AgentAction {
  const GreetingAction();
}

class UnknownAction extends AgentAction {
  final String originalMessage;
  const UnknownAction({required this.originalMessage});
}

// ─── Análisis financiero (IA avanzada) ─────────────────────────────────────

class SpendingAnalysisAction extends AgentAction {
  final DateTime? fromDate;
  final DateTime? toDate;
  const SpendingAnalysisAction({this.fromDate, this.toDate});
}

class SpendingByCategoryAction extends AgentAction {
  final String category;
  final DateTime? fromDate;
  final DateTime? toDate;
  const SpendingByCategoryAction({
    required this.category,
    this.fromDate,
    this.toDate,
  });
}
