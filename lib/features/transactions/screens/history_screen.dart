import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/utils/format_utils.dart';
import '../../../services/mock_data_service.dart';
import '../models/transaction.dart';

/// HU 1.2 / HU 4.2 – Pantalla de Historial de Transacciones
/// Consulta del historial con filtros y estados
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'Todas';
  final List<String> _filters = [
    'Todas',
    'Ingresos',
    'Egresos',
    'Pendientes',
  ];

  List<Transaction> get _filteredTransactions {
    final all = MockDataService.transactions;
    switch (_selectedFilter) {
      case 'Ingresos':
        return all.where((t) => t.isIncome).toList();
      case 'Egresos':
        return all.where((t) => t.isExpense).toList();
      case 'Pendientes':
        return all
            .where((t) => t.status == TransactionStatus.pending)
            .toList();
      default:
        return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _filteredTransactions;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: Column(
        children: [
          // Filtros
          _buildFilters(),
          // Lista
          Expanded(
            child: transactions.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(AppDimens.paddingLG),
                    itemCount: transactions.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppDimens.marginSM),
                    itemBuilder: (context, index) {
                      return _buildTransactionCard(transactions[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingLG,
          vertical: AppDimens.paddingSM,
        ),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppDimens.marginSM),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;
          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              setState(() => _selectedFilter = filter);
            },
            selectedColor: AppColors.primary,
            labelStyle: GoogleFonts.inter(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: AppDimens.fontSM,
            ),
            backgroundColor: AppColors.surface,
            checkmarkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusRound),
            ),
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionCard(Transaction tx) {
    final isIncome = tx.isIncome;
    return Container(
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
          // Ícono
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (isIncome ? AppColors.income : AppColors.expense)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusMD),
            ),
            alignment: Alignment.center,
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? AppColors.income : AppColors.expense,
            ),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          // Detalles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  tx.description,
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontSM,
                    color: AppColors.textLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      FormatUtils.dateRelative(tx.date),
                      style: GoogleFonts.inter(
                        fontSize: AppDimens.fontXS,
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusBadge(tx),
                  ],
                ),
              ],
            ),
          ),
          // Monto
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

  Widget _buildStatusBadge(Transaction tx) {
    Color color;
    switch (tx.status) {
      case TransactionStatus.completed:
        color = AppColors.success;
        break;
      case TransactionStatus.pending:
        color = AppColors.warning;
        break;
      case TransactionStatus.failed:
        color = AppColors.error;
        break;
      case TransactionStatus.cancelled:
        color = AppColors.textLight;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimens.radiusRound),
      ),
      child: Text(
        tx.statusLabel,
        style: GoogleFonts.inter(
          fontSize: AppDimens.fontXS,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AppColors.textLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppDimens.paddingMD),
          Text(
            'No hay transacciones',
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontLG,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
