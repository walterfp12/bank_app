import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../models/agent_message.dart';

/// Burbuja de chat para mensajes del agente y del usuario
class AgentChatBubble extends StatelessWidget {
  final AgentMessage message;
  final VoidCallback? onSuggestionTap;
  final void Function(AgentSuggestion)? onSuggestionSelected;

  const AgentChatBubble({
    super.key,
    required this.message,
    this.onSuggestionTap,
    this.onSuggestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isUser ? 60 : 16,
          right: isUser ? 16 : 60,
          top: 4,
          bottom: 4,
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Burbuja principal
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.secondary : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4),
                  bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryDark],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            size: 12,
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'BAM AI',
                          style: TextStyle(
                            fontSize: AppDimens.fontXS,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  _buildMessageText(isUser),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),

            // Sugerencias rápidas
            if (message.hasSuggestions && !isUser) ...[
              const SizedBox(height: 8),
              _buildSuggestions(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageText(bool isUser) {
    // Parseo básico de markdown: **bold**
    final text = message.text;
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\*\*(.*?)\*\*');
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: TextStyle(
            fontSize: AppDimens.fontMD,
            color: isUser ? Colors.white : AppColors.textPrimary,
            height: 1.5,
          ),
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          fontSize: AppDimens.fontMD,
          fontWeight: FontWeight.w700,
          color: isUser ? Colors.white : AppColors.textPrimary,
          height: 1.5,
        ),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: TextStyle(
          fontSize: AppDimens.fontMD,
          color: isUser ? Colors.white : AppColors.textPrimary,
          height: 1.5,
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildSuggestions() {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: message.suggestions!.map((s) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onSuggestionSelected?.call(s),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                s.label,
                style: const TextStyle(
                  fontSize: AppDimens.fontSM,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
