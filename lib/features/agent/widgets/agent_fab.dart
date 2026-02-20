import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Floating Action Button animado para el agente IA
/// Se muestra sobre la BottomNavigationBar con efecto glow pulsante
class AgentFab extends StatefulWidget {
  final VoidCallback onTap;

  const AgentFab({super.key, required this.onTap});

  @override
  State<AgentFab> createState() => _AgentFabState();
}

class _AgentFabState extends State<AgentFab> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: 0.3 + 0.2 * _pulseAnimation.value,
                ),
                blurRadius: 16 + 8 * _pulseAnimation.value,
                spreadRadius: 2 * _pulseAnimation.value,
              ),
            ],
          ),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.surface,
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: AppColors.textOnPrimary,
            size: 28,
          ),
        ),
      ),
    );
  }
}
