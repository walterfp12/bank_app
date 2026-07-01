import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/utils/format_utils.dart';
import '../../../../core/widgets/bank_card_widget.dart';
import '../../../../core/widgets/quick_action_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/payment_card.dart';
import '../../domain/entities/recent_transaction.dart';
import '../controllers/dashboard_controller.dart';
import '../states/dashboard_state.dart';

/// HU 3.2 – Dashboard de productos y saldos.
///
/// La pantalla observa el [DashboardState] del Notifier y renderiza la variante
/// correspondiente: cargando, error o datos. No accede a mocks ni repositorios
/// directamente — solo consume estado.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: switch (state) {
          DashboardInitial() ||
          DashboardLoading() =>
            _LoadingView(message: l10n.stateLoadingDashboard),
          DashboardError(:final message) => _ErrorView(
              message: message,
              onRetry: () =>
                  ref.read(dashboardControllerProvider.notifier).refresh(),
            ),
          DashboardLoaded(:final data, :final fromCache) => _DashboardContent(
              data: data,
              fromCache: fromCache,
              onRefresh: () =>
                  ref.read(dashboardControllerProvider.notifier).refresh(),
            ),
        },
      ),
    );
  }
}

// ─── Estado: Cargando ─────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  final String message;
  const _LoadingView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: AppDimens.paddingLG),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontMD,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Estado: Error ────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 56, color: AppColors.error),
            const SizedBox(height: AppDimens.paddingMD),
            Text(
              l10n.stateErrorTitle,
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontLG,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontSM,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingLG),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.stateRetry),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Estado: Datos cargados ───────────────────────────────────────────────────

class _DashboardContent extends StatelessWidget {
  final DashboardData data;
  final bool fromCache;
  final Future<void> Function() onRefresh;

  const _DashboardContent({
    required this.data,
    required this.fromCache,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header(l10n)),
          if (fromCache) SliverToBoxAdapter(child: _cacheBanner(l10n)),
          SliverToBoxAdapter(child: _balanceCard(l10n)),
          SliverToBoxAdapter(child: _quickActions(l10n)),
          SliverToBoxAdapter(child: _cardsSection(l10n)),
          SliverToBoxAdapter(child: _accountsSection(context, l10n)),
          SliverToBoxAdapter(child: _transactionsSection(l10n)),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppDimens.paddingXXL),
          ),
        ],
      ),
    );
  }

  Widget _header(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingLG,
        AppDimens.paddingLG,
        AppDimens.paddingLG,
        AppDimens.paddingSM,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: Text(
              data.userInitials,
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
                  l10n.dashboardGreeting,
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  data.userName,
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontXL,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cacheBanner(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLG),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingMD,
        vertical: AppDimens.paddingSM,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDimens.radiusSM),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off, size: 16, color: AppColors.warning),
          const SizedBox(width: 8),
          Text(
            l10n.cacheBadge,
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontSM,
              color: AppColors.warning,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceCard(AppLocalizations l10n) {
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
              l10n.dashboardTotalBalance,
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontMD,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              FormatUtils.currency(data.totalBalance),
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontHero,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Row(
              children: [
                const Icon(Icons.trending_up,
                    color: AppColors.success, size: 16),
                const SizedBox(width: 4),
                Text(
                  l10n.dashboardMonthChange,
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

  Widget _quickActions(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashboardQuickActions,
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
                  icon: Icons.swap_horiz, label: l10n.actionTransfer, onTap: () {}),
              QuickActionButton(
                  icon: Icons.payment, label: l10n.actionPay, onTap: () {}),
              QuickActionButton(
                  icon: Icons.qr_code_scanner, label: l10n.actionQr, onTap: () {}),
              QuickActionButton(
                  icon: Icons.receipt_long, label: l10n.actionHistory, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardsSection(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(l10n.dashboardMyCards, l10n),
          const SizedBox(height: AppDimens.paddingSM),
          // Carrusel horizontal: distintos tipos de tarjeta (débito/crédito/prepago)
          SizedBox(
            height: AppDimens.cardHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.cards.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: AppDimens.paddingMD),
              itemBuilder: (context, i) {
                final card = data.cards[i];
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: BankCardWidget(
                    cardNumber: FormatUtils.maskCardNumber(card.number),
                    holderName: card.holderName,
                    expiryDate: card.expiryDate,
                    cardType: _cardTypeLabel(card.type, l10n),
                    brandLabel: _brandLabel(card.brand),
                    gradient: _cardGradient(card.type),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountsSection(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(l10n.dashboardMyAccounts, l10n),
          const SizedBox(height: AppDimens.paddingSM),
          ...data.accounts.map((acc) => _accountTile(acc, l10n)),
        ],
      ),
    );
  }

  Widget _accountTile(Account account, AppLocalizations l10n) {
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
            child: Text(_accountIcon(account.type),
                style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _accountTypeLabel(account.type, l10n),
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

  Widget _transactionsSection(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(l10n.dashboardRecentTransactions, l10n),
          const SizedBox(height: AppDimens.paddingSM),
          ...data.recentTransactions.map(_transactionTile),
        ],
      ),
    );
  }

  Widget _transactionTile(RecentTransaction tx) {
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
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

  Widget _sectionTitle(String title, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: AppDimens.fontLG,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(onPressed: () {}, child: Text(l10n.dashboardSeeAll)),
      ],
    );
  }

  // ─── Mapeos de presentación (enum → UI) ─────────────────────────────────────

  String _cardTypeLabel(CardType type, AppLocalizations l10n) => switch (type) {
        CardType.debit => l10n.cardDebit,
        CardType.credit => l10n.cardCredit,
        CardType.prepaid => 'Prepago',
      };

  String _brandLabel(CardBrand brand) => switch (brand) {
        CardBrand.visa => 'VISA',
        CardBrand.mastercard => 'MASTERCARD',
        CardBrand.amex => 'AMEX',
      };

  LinearGradient _cardGradient(CardType type) => switch (type) {
        CardType.debit => AppColors.cardGradient,
        CardType.credit => const LinearGradient(
            colors: [Color(0xFF1E293B), Color(0xFF475569)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        CardType.prepaid => const LinearGradient(
            colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      };

  String _accountTypeLabel(AccountType type, AppLocalizations l10n) =>
      switch (type) {
        AccountType.savings => l10n.accountSavings,
        AccountType.checking => l10n.accountChecking,
        AccountType.credit => l10n.accountCredit,
      };

  String _accountIcon(AccountType type) => switch (type) {
        AccountType.savings => '🏦',
        AccountType.checking => '💼',
        AccountType.credit => '💳',
      };
}
