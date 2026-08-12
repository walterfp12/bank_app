import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/push_message.dart';
import '../providers/notifications_providers.dart';
import '../states/notifications_state.dart';

/// Controller de notificaciones – capa Presentation (HU 4.3).
///
/// Devuelve un [NotificationsState] propio. Se encarga de:
/// 1. pedir permiso al usuario,
/// 2. obtener el token FCM del dispositivo,
/// 3. escuchar los mensajes entrantes y acumularlos en el estado.
class NotificationsController extends Notifier<NotificationsState> {
  StreamSubscription<PushMessage>? _subscription;

  @override
  NotificationsState build() {
    ref.onDispose(() => _subscription?.cancel());
    return const NotificationsState.initial();
  }

  /// Configura FCM. Se llama al entrar a la pantalla de notificaciones.
  Future<void> initialize() async {
    if (state is NotificationsReady) return;

    state = const NotificationsState.loading();

    final permission =
        await ref.read(requestNotificationPermissionUseCaseProvider).call();

    final granted = permission.dataOrNull ?? false;
    if (!granted) {
      state = const NotificationsState.permissionDenied();
      return;
    }

    final tokenResult = await ref.read(getDeviceTokenUseCaseProvider).call();

    tokenResult.when(
      success: (token) {
        state = NotificationsState.ready(token: token);
        _listenMessages();
      },
      failure: (error) =>
          state = NotificationsState.error(message: error.friendlyMessage),
    );
  }

  /// Acumula cada mensaje entrante al inicio de la lista.
  void _listenMessages() {
    _subscription?.cancel();
    _subscription = ref
        .read(notificationRepositoryProvider)
        .messages
        .listen(_onMessage);
  }

  void _onMessage(PushMessage message) {
    final current = state;
    if (current is! NotificationsReady || !message.hasContent) return;

    // Evita duplicados por reentrega del mismo messageId.
    if (current.messages.any((m) => m.id == message.id)) return;

    state = current.copyWith(messages: [message, ...current.messages]);
  }

  void clear() {
    final current = state;
    if (current is NotificationsReady) {
      state = current.copyWith(messages: const []);
    }
  }
}

final notificationsControllerProvider =
    NotifierProvider<NotificationsController, NotificationsState>(
  NotificationsController.new,
);
