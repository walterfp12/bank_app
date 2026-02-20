/// Modelo de mensaje del agente IA bancario
enum MessageType {
  text,
  richCard,
  actionConfirmation,
  actionResult,
  loading,
  suggestion,
  error,
}

enum MessageSender { user, agent }

class AgentMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final MessageType type;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;
  final List<AgentSuggestion>? suggestions;
  final AgentRichContent? richContent;

  const AgentMessage({
    required this.id,
    required this.text,
    required this.sender,
    this.type = MessageType.text,
    required this.timestamp,
    this.metadata,
    this.suggestions,
    this.richContent,
  });

  bool get isUser => sender == MessageSender.user;
  bool get isAgent => sender == MessageSender.agent;
  bool get isLoading => type == MessageType.loading;
  bool get hasSuggestions => suggestions != null && suggestions!.isNotEmpty;
  bool get hasRichContent => richContent != null;

  AgentMessage copyWith({
    String? id,
    String? text,
    MessageSender? sender,
    MessageType? type,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
    List<AgentSuggestion>? suggestions,
    AgentRichContent? richContent,
  }) {
    return AgentMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
      suggestions: suggestions ?? this.suggestions,
      richContent: richContent ?? this.richContent,
    );
  }
}

/// Sugerencia rápida que el agente puede ofrecer
class AgentSuggestion {
  final String label;
  final String action;
  final String? icon;

  const AgentSuggestion({
    required this.label,
    required this.action,
    this.icon,
  });
}

/// Contenido enriquecido dentro de un mensaje del agente
enum RichContentType {
  accountList,
  transactionList,
  balanceSummary,
  transferConfirmation,
  transferResult,
  cardInfo,
  userProfile,
}

class AgentRichContent {
  final RichContentType type;
  final Map<String, dynamic> data;

  const AgentRichContent({
    required this.type,
    required this.data,
  });
}
