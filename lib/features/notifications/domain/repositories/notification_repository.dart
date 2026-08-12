import '../../../../core/errors/result.dart';
import '../entities/push_message.dart';

/// Contrato del repositorio de notificaciones – capa Domain (HU 4.3).
abstract interface class NotificationRepository {
  /// Pide permiso al usuario para mostrar notificaciones.
  /// Devuelve true si quedó autorizado.
  Future<Result<bool>> requestPermission();

  /// Token FCM de este dispositivo (el que se usa para enviarle push).
  Future<Result<String>> getDeviceToken();

  /// Flujo de mensajes entrantes, ya convertidos a entidad de dominio.
  Stream<PushMessage> get messages;
}
