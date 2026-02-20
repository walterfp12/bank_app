import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../models/agent_message.dart';
import '../services/agent_service.dart';
import '../widgets/agent_chat_bubble.dart';
import '../widgets/agent_rich_card.dart';
import '../widgets/agent_typing_indicator.dart';

/// Pantalla principal del agente IA bancario
/// Interfaz conversacional completa con:
/// - Chat en tiempo real con burbujas estilizadas
/// - Tarjetas enriquecidas inline (saldos, transacciones, confirmaciones)
/// - Sugerencias rápidas interactivas
/// - Indicador de "escribiendo" animado
/// - Navegación contextual (el agente puede navegar a otras pantallas)
class AgentChatScreen extends StatefulWidget {
  const AgentChatScreen({super.key});

  @override
  State<AgentChatScreen> createState() => _AgentChatScreenState();
}

class _AgentChatScreenState extends State<AgentChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<AgentMessage> _messages = [];
  bool _isTyping = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    // Limpiar historial al abrir el chat
    AgentService.clearHistory();

    // Delay para efecto visual
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => _isTyping = true);

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    final welcome = AgentService.welcomeMessage;
    setState(() {
      _isTyping = false;
      _messages.add(welcome);
      _isInitialized = true;
    });

    _scrollToBottom();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = AgentMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      text: text.trim(),
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isTyping = true;
    });

    _textController.clear();
    _scrollToBottom();

    try {
      final response = await AgentService.processMessage(text.trim());

      if (!mounted) return;

      setState(() {
        _isTyping = false;
        _messages.add(response);
      });

      _scrollToBottom();

      // Si el agente pide navegar, hacerlo después de un breve delay
      if (response.metadata != null && response.metadata!.containsKey('navigate')) {
        await Future.delayed(const Duration(milliseconds: 800));
        if (mounted) {
          final route = response.metadata!['navigate'] as String;
          context.go(route);
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(AgentMessage(
          id: 'error_${DateTime.now().millisecondsSinceEpoch}',
          text: '⚠️ Ocurrió un error. Intenta de nuevo.',
          sender: MessageSender.agent,
          type: MessageType.error,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  void _handleSuggestionTap(AgentSuggestion suggestion) {
    _handleSendMessage(suggestion.action);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        onPressed: () => context.pop(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: AppColors.textOnPrimary, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BAM AI',
                style: TextStyle(
                  fontSize: AppDimens.fontLG,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.income,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isTyping ? 'Escribiendo...' : 'En línea',
                    style: TextStyle(
                      fontSize: AppDimens.fontXS,
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
          onPressed: () => _showOptionsMenu(context),
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    if (!_isInitialized && !_isTyping) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isTyping && index == _messages.length) {
          return const AgentTypingIndicator();
        }

        final message = _messages[index];

        return Column(
          children: [
            AgentChatBubble(
              message: message,
              onSuggestionSelected: _handleSuggestionTap,
            ),
            // Rich content card debajo de la burbuja del agente
            if (message.hasRichContent && message.isAgent)
              AgentRichCard(content: message.richContent!),
          ],
        );
      },
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.send,
                onSubmitted: _handleSendMessage,
                style: const TextStyle(fontSize: AppDimens.fontMD),
                decoration: InputDecoration(
                  hintText: 'Escribe tu mensaje...',
                  hintStyle: TextStyle(color: AppColors.textLight),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  prefixIcon: Icon(
                    Icons.mic_outlined,
                    color: AppColors.textLight.withValues(alpha: 0.5),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _handleSendMessage(_textController.text),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.send_rounded,
                color: AppColors.textOnPrimary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.textLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: AppColors.expense),
                title: const Text('Limpiar conversación'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _messages.clear();
                    AgentService.clearHistory();
                  });
                  _initializeChat();
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('¿Qué puedo hacer?'),
                onTap: () {
                  Navigator.pop(context);
                  _handleSendMessage('ayuda');
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
