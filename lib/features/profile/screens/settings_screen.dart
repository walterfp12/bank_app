import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/i18n/locale_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/domain/entities/auth_user.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../auth/presentation/states/auth_state.dart';

/// HU 1.2 – Pantalla de Configuración / Perfil
/// HU 2.3 – Logout via Riverpod AuthController
/// HU 3.3 – Selector de idioma (i18n)
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeControllerProvider);

    // HU 4.1 – El perfil muestra el usuario real de Firebase Auth.
    final authState = ref.watch(authControllerProvider);
    final user = authState is AuthStateAuthenticated
        ? authState.session.user
        : const AuthUser(id: '', email: '');

    final currentLanguage = locale.languageCode == 'es'
        ? l10n.languageSpanish
        : l10n.languageEnglish;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingLG),
        child: Column(
          children: [
            _buildProfileHeader(user),
            const SizedBox(height: AppDimens.paddingLG),
            _buildSection(
              title: l10n.settingsAccount,
              items: [
                _SettingsItem(
                  icon: Icons.person_outline,
                  title: l10n.settingsPersonalInfo,
                  subtitle: l10n.settingsPersonalInfoSub,
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.security,
                  title: l10n.settingsSecurity,
                  subtitle: l10n.settingsSecuritySub,
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.notifications_outlined,
                  title: l10n.settingsNotifications,
                  subtitle: l10n.settingsNotificationsSub,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingMD),
            _buildSection(
              title: l10n.settingsPreferences,
              items: [
                _SettingsItem(
                  icon: Icons.language,
                  title: l10n.settingsLanguage,
                  subtitle: currentLanguage,
                  onTap: () => _showLanguageSelector(context, ref),
                ),
                _SettingsItem(
                  icon: Icons.palette_outlined,
                  title: l10n.settingsAppearance,
                  subtitle: l10n.settingsAppearanceSub,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingMD),
            _buildSection(
              title: l10n.settingsSupport,
              items: [
                _SettingsItem(
                  icon: Icons.help_outline,
                  title: l10n.settingsHelp,
                  subtitle: l10n.settingsHelpSub,
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  title: l10n.settingsAbout,
                  subtitle: l10n.settingsAboutSub,
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
                  l10n.settingsLogout,
                  style: GoogleFonts.inter(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  minimumSize:
                      const Size(double.infinity, AppDimens.buttonHeight),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.paddingXXL),
          ],
        ),
      ),
    );
  }

  /// HU 3.3 – Bottom sheet para elegir idioma. Al seleccionar, el
  /// LocaleController actualiza el estado y MaterialApp reconstruye toda la UI.
  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = ref.read(localeControllerProvider).languageCode;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppDimens.paddingMD),
              Text(
                l10n.languageSelectTitle,
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontLG,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.paddingSM),
              _languageTile(ctx, ref, '🇬🇹', l10n.languageSpanish, 'es', current),
              _languageTile(ctx, ref, '🇺🇸', l10n.languageEnglish, 'en', current),
              const SizedBox(height: AppDimens.paddingMD),
            ],
          ),
        );
      },
    );
  }

  Widget _languageTile(
    BuildContext context,
    WidgetRef ref,
    String flag,
    String label,
    String code,
    String current,
  ) {
    final selected = code == current;
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : null,
      onTap: () {
        ref.read(localeControllerProvider.notifier).setLocale(Locale(code));
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildProfileHeader(AuthUser user) {
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
                  user.name,
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
              final item = entry.value;
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
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textLight),
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
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
