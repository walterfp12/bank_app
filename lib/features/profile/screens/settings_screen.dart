import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../services/mock_data_service.dart';
import '../../../services/user_profile.dart';
import '../../auth/presentation/controllers/auth_controller.dart';

/// HU 1.2 – Pantalla de Configuración / Perfil
/// HU 2.3 – Logout via Riverpod AuthController
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = MockDataService.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Configuración')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingLG),
        child: Column(
          children: [
            _buildProfileHeader(user),
            const SizedBox(height: AppDimens.paddingLG),
            _buildSection(
              title: 'Cuenta',
              items: [
                _SettingsItem(
                  icon: Icons.person_outline,
                  title: 'Información Personal',
                  subtitle: 'Nombre, correo, teléfono',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.security,
                  title: 'Seguridad',
                  subtitle: 'Contraseña, biometría',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notificaciones',
                  subtitle: 'Push, correo, SMS',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingMD),
            _buildSection(
              title: 'Preferencias',
              items: [
                _SettingsItem(
                  icon: Icons.language,
                  title: 'Idioma',
                  subtitle: 'Español',
                  onTap: () {
                    // TODO HU 3.3 – Selector de idioma i18n
                  },
                ),
                _SettingsItem(
                  icon: Icons.palette_outlined,
                  title: 'Apariencia',
                  subtitle: 'Tema claro',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingMD),
            _buildSection(
              title: 'Soporte',
              items: [
                _SettingsItem(
                  icon: Icons.help_outline,
                  title: 'Ayuda y Soporte',
                  subtitle: 'FAQ, contacto',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  title: 'Acerca de',
                  subtitle: 'BAM Wallet v1.0.0',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingXL),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).logout(),
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: Text(
                  'Cerrar Sesión',
                  style: GoogleFonts.inter(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  minimumSize: const Size(double.infinity, AppDimens.buttonHeight),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.paddingXXL),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserProfile user) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary,
            child: Text(
              user.initials,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppDimens.fontXL,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimens.fontLG,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontSM,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<_SettingsItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: AppDimens.fontSM,
            fontWeight: FontWeight.w600,
            color: AppColors.textLight,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: AppDimens.paddingSM),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusMD),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final item  = entry.value;
              final isLast = entry.key == items.length - 1;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(item.icon, color: AppColors.primary),
                    title: Text(
                      item.title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimens.fontMD,
                      ),
                    ),
                    subtitle: Text(
                      item.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: AppDimens.fontSM,
                        color: AppColors.textLight,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
                    onTap: item.onTap,
                  ),
                  if (!isLast) const Divider(height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String   title;
  final String   subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
