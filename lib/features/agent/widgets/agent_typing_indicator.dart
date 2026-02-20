import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Indicador de "escribiendo..." del agente IA con animación de puntos
class AgentTypingIndicator extends StatefulWidget {
  const AgentTypingIndicator({super.key});

  @override
  State<AgentTypingIndicator> createState() => _AgentTypingIndicatorState();
}

class _AgentTypingIndicatorState extends State<AgentTypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _animations = _controllers.map((c) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();

    // Staggered start
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 180), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 80),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.textOnPrimary,
              ),
            ),
            const SizedBox(width: 12),
            ...List.generate(3, (i) {
              return AnimatedBuilder(
                animation: _animations[i],
                builder: (_, __) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    child: Transform.translate(
                      offset: Offset(0, -4 * _animations[i].value),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(
                            alpha: 0.4 + 0.6 * _animations[i].value,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
