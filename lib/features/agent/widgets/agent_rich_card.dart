import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/utils/format_utils.dart';
import '../models/agent_message.dart';

/// Tarjetas enriquecidas que se muestran inline en el chat del agente.
/// Representan datos estructurados como cuentas, transacciones, confirmaciones.
class AgentRichCard extends StatelessWidget {
  final AgentRichContent content;

  const AgentRichCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return switch (content.type) {
      RichContentType.balanceSummary => _buildBalanceSummary(),
      RichContentType.accountList => _buildAccountList(),
      RichContentType.transactionList => _buildTransactionList(),
      RichContentType.transferConfirmation => _buildTransferConfirmation(),
      RichContentType.transferResult => _buildTransferResult(),
      RichContentType.cardInfo => _buildCardInfo(),
      RichContentType.userProfile => _buildUserProfile(),
    };
  }

  Widget _buildBalanceSummary() {
    final totalBalance = content.data['totalBalance'] as double?;
    final accounts = content.data['accounts'] as List<dynamic>? ?? [];

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF111827), Color(0xFF1F2937)],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (totalBalance != null) ...[
            const Text(
              'Balance Total',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              FormatUtils.currency(totalBalance),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Divider(color: Colors.white12, height: 24),
          ],
          ...accounts.map<Widget>((acc) {
            final a = acc as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      a['name'] as String? ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Text(
                    FormatUtils.currency(a['balance'] as double? ?? 0),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAccountList() {
    final accounts = content.data['accounts'] as List<dynamic>? ?? [];

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      child: Column(
        children: accounts.map<Widget>((acc) {
          final a = acc as Map<String, dynamic>;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimens.radiusMD),
              border: Border.all(color: AppColors.surfaceVariant),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.account_balance, color: AppColors.primaryDark, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a['name'] as String? ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      Text(
                        a['type'] as String? ?? '',
                        style: const TextStyle(color: AppColors.textLight, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Text(
                  FormatUtils.currency(a['balance'] as double? ?? 0),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionList() {
    final transactions = content.data['transactions'] as List<dynamic>? ?? [];

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      child: Column(
        children: transactions.take(5).map<Widget>((t) {
          final tx = t as Map<String, dynamic>;
          final isIncome = tx['isIncome'] as bool? ?? false;
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimens.radiusSM),
              border: Border.all(color: AppColors.surfaceVariant),
            ),
            child: Row(
              children: [
                Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? AppColors.income : AppColors.expense,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tx['title'] as String? ?? '',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${isIncome ? '+' : '-'}${FormatUtils.currency(tx['amount'] as double? ?? 0)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isIncome ? AppColors.income : AppColors.expense,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransferConfirmation() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        children: [
          const Icon(Icons.swap_horiz, color: AppColors.primary, size: 32),
          const SizedBox(height: 8),
          const Text('Confirmar Transferencia', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          _transferRow('Desde', content.data['fromAccount'] as String? ?? ''),
          _transferRow('Para', content.data['toRecipient'] as String? ?? ''),
          _transferRow('Monto', FormatUtils.currency(content.data['amount'] as double? ?? 0)),
          _transferRow('Concepto', content.data['description'] as String? ?? ''),
        ],
      ),
    );
  }

  Widget _buildTransferResult() {
    final status = content.data['status'] as String? ?? '';
    final isSuccess = status == 'completed';

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSuccess ? AppColors.income.withValues(alpha: 0.05) : AppColors.expense.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        border: Border.all(
          color: isSuccess ? AppColors.income.withValues(alpha: 0.3) : AppColors.expense.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? AppColors.income : AppColors.expense,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            isSuccess ? '¡Transferencia Exitosa!' : 'Error en Transferencia',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: isSuccess ? AppColors.income : AppColors.expense,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            FormatUtils.currency(content.data['amount'] as double? ?? 0),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            'Ref: ${content.data['reference'] ?? 'N/A'}',
            style: const TextStyle(color: AppColors.textLight, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfo() {
    final cards = content.data['cards'] as List<dynamic>? ?? [];

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      child: Column(
        children: cards.map<Widget>((c) {
          final card = c as Map<String, dynamic>;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(AppDimens.radiusLG),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card['brand'] as String? ?? '',
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                    Text(
                      card['type'] as String? ?? '',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '•••• •••• •••• ${(card['number'] as String? ?? '').split(' ').last}',
                  style: const TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card['holder'] as String? ?? '',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    Text(
                      card['expiry'] as String? ?? '',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 60, top: 4, bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: Text(
              (content.data['full_name'] as String? ?? 'W').substring(0, 1),
              style: const TextStyle(
                color: AppColors.textOnPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content.data['full_name'] as String? ?? '',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            content.data['email'] as String? ?? '',
            style: const TextStyle(color: AppColors.textLight, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _transferRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 13)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
