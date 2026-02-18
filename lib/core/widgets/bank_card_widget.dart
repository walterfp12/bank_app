import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// Tarjeta visual de cuenta bancaria / tarjeta de crédito
class BankCardWidget extends StatelessWidget {
  final String cardNumber;
  final String holderName;
  final String expiryDate;
  final String cardType;
  final String brandLabel;
  final LinearGradient? gradient;

  const BankCardWidget({
    super.key,
    required this.cardNumber,
    required this.holderName,
    required this.expiryDate,
    required this.cardType,
    required this.brandLabel,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimens.cardHeight,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppDimens.cardBorderRadius),
        boxShadow: AppColors.buttonShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header: Tipo y marca
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardType,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: AppDimens.fontSM,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  brandLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppDimens.fontXL,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            // Chip simulado
            Container(
              width: 45,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            // Número de tarjeta
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppDimens.fontXL,
                fontWeight: FontWeight.w500,
                letterSpacing: 3,
              ),
            ),
            // Footer: Nombre y fecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TITULAR',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: AppDimens.fontXS,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      holderName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppDimens.fontSM,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'VENCE',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: AppDimens.fontXS,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      expiryDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppDimens.fontSM,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
