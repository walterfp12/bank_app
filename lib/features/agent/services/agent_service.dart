import 'dart:async';
import '../models/agent_message.dart';
import '../models/agent_action.dart';
import 'intent_resolver.dart';
import 'action_executor.dart';

/// Servicio principal del agente IA bancario.
///
/// Orquesta el flujo completo:
/// 1. Recibe mensaje del usuario
/// 2. Resuelve la intención (IntentResolver)
/// 3. Ejecuta la acción (ActionExecutor)
/// 4. Devuelve respuesta formateada
///
/// ARQUITECTURA:
/// - Diseñado para ser drop-in reemplazable con un LLM real
/// - El flujo User → Intent → Action → Response se mantiene igual
/// - Solo cambia el IntentResolver por una llamada a OpenAI/Gemini
class AgentService {
  AgentService._();

  static final List<AgentMessage> _conversationHistory = [];

  /// Historial de la conversación
  static List<AgentMessage> get history => List.unmodifiable(_conversationHistory);

  /// Limpia el historial
  static void clearHistory() {
    _conversationHistory.clear();
  }

  /// Mensaje de bienvenida inicial
  static AgentMessage get welcomeMessage {
    final msg = ActionExecutor.execute(const GreetingAction());
    return msg;
  }

  /// Procesa un mensaje del usuario y devuelve la respuesta del agente.
  /// Simula un delay para dar sensación de "pensando".
  static Future<AgentMessage> processMessage(String userInput) async {
    // 1. Crear y guardar mensaje del usuario
    final userMessage = AgentMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      text: userInput,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    _conversationHistory.add(userMessage);

    // 2. Simular delay de procesamiento IA (300-800ms)
    await Future.delayed(
      Duration(milliseconds: 300 + (userInput.length * 10).clamp(0, 500)),
    );

    // 3. Resolver intención
    final action = IntentResolver.resolve(userInput);

    // 4. Ejecutar acción
    final response = ActionExecutor.execute(action);

    // 5. Guardar respuesta en historial
    _conversationHistory.add(response);

    return response;
  }

  /// Procesa una sugerencia rápida (mismo flujo que un mensaje)
  static Future<AgentMessage> processSuggestion(AgentSuggestion suggestion) {
    return processMessage(suggestion.action);
  }

  /// Verifica si hay una transferencia pendiente de confirmación
  static bool get hasPendingAction => ActionExecutor.hasPendingTransfer;
}
