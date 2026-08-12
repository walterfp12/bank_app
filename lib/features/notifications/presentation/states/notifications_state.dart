import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/push_message.dart';

part 'notifications_state.freezed.dart';

/// Estado de la pantalla de notificaciones – capa Presentation (HU 4.3).
///
/// Igual que en los demás features: el Notifier devuelve este estado, no una
/// lista de mensajes.
@freezed
sealed class NotificationsState with _$NotificationsState {
  /// Todavía no se ha configurado FCM.
  const factory NotificationsState.initial() = NotificationsInitial;

  /// Pidiendo permiso y obteniendo el token.
  const factory NotificationsState.loading() = NotificationsLoading;

  /// El usuario rechazó el permiso de notificaciones.
  const factory NotificationsState.permissionDenied() =
      NotificationsPermissionDenied;

  /// Todo listo: hay token y se están escuchando mensajes.
  const factory NotificationsState.ready({
    /// Token FCM de este dispositivo.
    required String token,

    /// Mensajes recibidos, del más reciente al más antiguo.
    @Default(<PushMessage>[]) List<PushMessage> messages,
  }) = NotificationsReady;

  /// Falló la configuración de FCM.
  const factory NotificationsState.error({required String message}) =
      NotificationsError;
}
