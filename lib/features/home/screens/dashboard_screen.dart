import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/widgets/bank_card_widget.dart';
import '../../../core/widgets/quick_action_button.dart';
import '../../../services/mock_data_service.dart';
import '../../accounts/models/bank_account.dart';
import '../../cards/models/bank_card.dart';
import '../../transactions/models/transaction.dart';

/// HU 1.2 / HU 3.2 – Dashboard principal
/// Visualización de productos financieros y saldos
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.currentUser;
    final accounts = MockDataService.accounts;
    final transactions = MockDataService.transactions.take(5).toList();
    final card = MockDataService.cards.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: _buildHeader(context, user.fullName, user.initials),
            ),
            // Saldo total
            SliverToBoxAdapter(
              child: _buildBalanceCard(context),
            ),
            // Acciones rápidas
            SliverToBoxAdapter(
              child: _buildQuickActions(context),
            ),
            // Tarjeta
            SliverToBoxAdapter(
              child: _buildCardSection(context, card),
            ),
            // Mis cuentas
            SliverToBoxAdapter(
              child: _buildAccountsList(context, accounts),
            ),
            // Transacciones recientes
            SliverToBoxAdapter(
              child: _buildTransactionsSection(context, transactions),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppDimens.paddingXXL),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name, String initials) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingLG,
        AppDimens.paddingLG,
        AppDimens.paddingLG,
        AppDimens.paddingSM,
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: Text(
              initials,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: AppDimens.fontLG,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hola 👋',
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontXL,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Notificaciones
          IconButton(
            onPressed: () {
              // TODO: HU 4.3 – Notificaciones push
            },
            icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.paddingLG),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimens.radiusXL),
          boxShadow: AppColors.buttonShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo Total',
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontMD,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              FormatUtils.currency(MockDataService.totalBalance),
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontHero,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Row(
              children: [
                const Icon(Icons.trending_up, color: AppColors.success, size: 16),
                const SizedBox(width: 4),
                Text(
                  '+2.5% este mes',
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontSM,
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acciones Rápidas',
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontLG,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMD),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickActionButton(
                icon: Icons.swap_horiz,
                label: 'Transferir',
                onTap: () {
                  // Navegar a transferencias
                },
              ),
              QuickActionButton(
                icon: Icons.payment,
                label: 'Pagar',
                onTap: () {},
              ),
              QuickActionButton(
                icon: Icons.qr_code_scanner,
                label: 'QR',
                onTap: () {},
              ),
              QuickActionButton(
                icon: Icons.receipt_long,
                label: 'Historial',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection(
    BuildContext context,
    BankCard card,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mi Tarjeta',
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontLG,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Ver todas'),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingSM),
          BankCardWidget(
            cardNumber: FormatUtils.maskCardNumber(card.cardNumber),
            holderName: card.holderName,
            expiryDate: card.expiryDate,
            cardType: card.typeLabel,
            brandLabel: card.brandLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList(BuildContext context, List<BankAccount> accounts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mis Cuentas',
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontLG,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Ver todas'),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingSM),
          ...accounts.map((account) => _buildAccountTile(account)),
        ],
      ),
    );
  }

  Widget _buildAccountTile(BankAccount account) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.marginSM),
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusSM),
            ),
            alignment: Alignment.center,
            child: Text(
              account.typeIcon,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.accountName,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  FormatUtils.maskAccountNumber(account.accountNumber),
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontSM,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            FormatUtils.currency(account.availableBalance),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: AppDimens.fontMD,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection(
    BuildContext context,
    List<Transaction> transactions,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transacciones Recientes',
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontLG,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Ver todas'),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingSM),
          ...transactions.map((tx) => _buildTransactionTile(tx)),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Transaction tx) {
    final isIncome = tx.isIncome;
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.marginSM),
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (isIncome ? AppColors.income : AppColors.expense)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusSM),
            ),
            alignment: Alignment.center,
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? AppColors.income : AppColors.expense,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  FormatUtils.dateRelative(tx.date),
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontSM,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}${FormatUtils.currency(tx.amount)}',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: AppDimens.fontMD,
              color: isIncome ? AppColors.income : AppColors.expense,
            ),
          ),
        ],
      ),
    );
  }
}
