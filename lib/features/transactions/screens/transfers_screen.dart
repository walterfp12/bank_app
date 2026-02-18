import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/utils/format_utils.dart';
import '../../../services/mock_data_service.dart';
import '../../accounts/models/bank_account.dart';

/// HU 1.2 – Pantalla de Transferencias
/// Permite iniciar transferencias entre cuentas
class TransfersScreen extends StatefulWidget {
  const TransfersScreen({super.key});

  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedAccountId;

  @override
  void initState() {
    super.initState();
    _selectedAccountId = MockDataService.accounts.first.id;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accounts = MockDataService.accounts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transferir'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingLG),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cuenta origen
              _buildSectionTitle('Desde'),
              const SizedBox(height: AppDimens.paddingSM),
              _buildAccountSelector(accounts),
              const SizedBox(height: AppDimens.paddingLG),

              // Destinatario
              _buildSectionTitle('Destinatario'),
              const SizedBox(height: AppDimens.paddingSM),
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'Número de cuenta o nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: AppDimens.paddingLG),

              // Monto
              _buildSectionTitle('Monto'),
              const SizedBox(height: AppDimens.paddingSM),
              TextFormField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Q 0.00',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontXXL,
                  fontWeight: FontWeight.w700,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa un monto';
                  final amount = double.tryParse(v);
                  if (amount == null || amount <= 0) return 'Monto inválido';
                  return null;
                },
              ),
              const SizedBox(height: AppDimens.paddingLG),

              // Descripción
              _buildSectionTitle('Descripción (opcional)'),
              const SizedBox(height: AppDimens.paddingSM),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Concepto de la transferencia',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              const SizedBox(height: AppDimens.paddingXL),

              // Botón transferir
              ElevatedButton(
                onPressed: _handleTransfer,
                child: const Text('Transferir'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: AppDimens.fontMD,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildAccountSelector(List<BankAccount> accounts) {
    return Container(
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
      child: RadioGroup<String>(
        groupValue: _selectedAccountId ?? '',
        onChanged: (String? value) {
          setState(() => _selectedAccountId = value);
        },
        child: Column(
          children: accounts.map<Widget>((account) {
            final isSelected = account.id == _selectedAccountId;
            return RadioListTile<String>(
              value: account.id,
              title: Text(
                account.accountName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimens.fontMD,
                ),
              ),
              subtitle: Text(
                'Disponible: ${FormatUtils.currency(account.availableBalance)}',
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontSM,
                  color: AppColors.textLight,
                ),
              ),
              activeColor: AppColors.primary,
              selected: isSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMD),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _handleTransfer() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Implementar lógica de transferencia real
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 28),
            SizedBox(width: 8),
            Text('Transferencia Enviada'),
          ],
        ),
        content: Text(
          'Se han transferido Q${_amountController.text} exitosamente.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _amountController.clear();
              _recipientController.clear();
              _descriptionController.clear();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
