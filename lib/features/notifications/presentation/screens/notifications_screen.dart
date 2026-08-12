import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/utils/format_utils.dart';
import '../../domain/entities/push_message.dart';
import '../controllers/notifications_controller.dart';
import '../states/notifications_state.dart';

/// HU 4.3 – Notificaciones push con Firebase Cloud Messaging.
///
/// Muestra el token FCM del dispositivo (para enviar la prueba desde la consola
/// de Firebase) y la bandeja de mensajes recibidos con la app abierta.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(notificationsControllerProvider.notifier).initialize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationsControllerProvider);
    final controller = ref.read(notificationsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          if (state is NotificationsReady && state.messages.isNotEmpty)
            IconButton(
              tooltip: 'Limpiar bandeja',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: controller.clear,
            ),
        ],
      ),
      body: switch (state) {
        NotificationsInitial() || NotificationsLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        NotificationsPermissionDenied() => _Denied(
            onRetry: controller.initialize,
          ),
        NotificationsError(:final message) => _ErrorView(
            message: message,
            onRetry: controller.initialize,
          ),
        NotificationsReady(:final token, :final messages) => _Ready(
            token: token,
            messages: messages,
          ),
      },
    );
  }
}

// ─── Estado: listo ────────────────────────────────────────────────────────────

class _Ready extends StatelessWidget {
  final String token;
  final List<PushMessage> messages;

  const _Ready({required this.token, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      children: [
        _TokenCard(token: token),
        const SizedBox(height: AppDimens.paddingLG),
        Row(
          children: [
            Text(
              'Bandeja',
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontLG,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            if (messages.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${messages.length}',
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontXS,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingMD),
        if (messages.isEmpty)
          const _WaitingForPush()
        else
          ...messages.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.marginSM),
                child: _MessageTile(message: m),
              )),
      ],
    );
  }
}

/// Tarjeta con el token FCM, copiable con un toque.
class _TokenCard extends StatelessWidget {
  final String token;
  const _TokenCard({required this.token});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        boxShadow: AppColors.buttonShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.key_outlined, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                'Token FCM de este dispositivo',
                style: GoogleFonts.inter(
                  fontSize: AppDimens.fontSM,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingSM),
          Text(
            token,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.robotoMono(
              fontSize: AppDimens.fontXS,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMD),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
              ),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Token copiado al portapapeles'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copiar token'),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaitingForPush extends StatelessWidget {
  const _WaitingForPush();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
      ),
      child: Column(
        children: [
          const Icon(Icons.notifications_active_outlined,
              size: 44, color: AppColors.textLight),
          const SizedBox(height: AppDimens.paddingMD),
          Text(
            'Esperando notificaciones',
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontMD,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Envía una push desde Firebase Console usando el token de arriba '
            'y aparecerá aquí.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: AppDimens.fontSM,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  final PushMessage message;
  const _MessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusSM),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.notifications,
                color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppDimens.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.title.isEmpty ? 'BAM Wallet' : message.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimens.fontMD,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (message.body.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    message.body,
                    style: GoogleFonts.inter(
                      fontSize: AppDimens.fontSM,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  FormatUtils.dateRelative(message.receivedAt),
                  style: GoogleFonts.inter(
                    fontSize: AppDimens.fontXS,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Estados de permiso / error ───────────────────────────────────────────────

class _Denied extends StatelessWidget {
  final VoidCallback onRetry;
  const _Denied({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.notifications_off_outlined,
                size: 56, color: AppColors.warning),
            const SizedBox(height: AppDimens.paddingMD),
            Text(
              'Permiso denegado',
              style: GoogleFonts.inter(
                fontSize: AppDimens.fontLG,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              'Activa las notificaciones para recibir avisos de tus movimientos.',
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
              label: const Text('Volver a intentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: AppColors.error),
            const SizedBox(height: AppDimens.paddingMD),
            Text(
              'No se pudo configurar FCM',
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
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
