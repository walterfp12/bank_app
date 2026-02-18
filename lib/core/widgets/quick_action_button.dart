import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// Botón de acción rápida para el dashboard
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? backgroundColor;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: (backgroundColor ?? AppColors.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusMD),
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: AppDimens.iconMD,
            ),
          ),
          const SizedBox(height: AppDimens.marginXS),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppDimens.fontSM,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
