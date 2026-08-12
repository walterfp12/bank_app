import '../../../../core/errors/result.dart';
import '../repositories/notification_repository.dart';

/// Caso de uso: solicitar permiso de notificaciones – capa Domain (HU 4.3).
///
/// Android 13+ exige permiso explícito del usuario para mostrar notificaciones.
class RequestNotificationPermissionUseCase {
  final NotificationRepository _repository;

  const RequestNotificationPermissionUseCase(this._repository);

  Future<Result<bool>> call() => _repository.requestPermission();
}
