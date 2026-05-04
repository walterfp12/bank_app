import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';

/// Widget de encabezado de la pantalla de login – capa Presentation
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusXL),
            boxShadow: AppColors.buttonShadow,
          ),
          child: const Icon(
            Icons.account_balance,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: AppDimens.paddingLG),
        Text(
          'BAM Wallet',
          style: GoogleFonts.inter(
            fontSize: AppDimens.fontDisplay,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppDimens.paddingXS),
        Text(
          'Bienvenido de nuevo',
          style: GoogleFonts.inter(
            fontSize: AppDimens.fontLG,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
