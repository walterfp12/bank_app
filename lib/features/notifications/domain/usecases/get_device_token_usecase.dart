import '../../../../core/errors/result.dart';
import '../repositories/notification_repository.dart';

/// Caso de uso: obtener el token FCM del dispositivo – capa Domain (HU 4.3).
class GetDeviceTokenUseCase {
  final NotificationRepository _repository;

  const GetDeviceTokenUseCase(this._repository);

  Future<Result<String>> call() => _repository.getDeviceToken();
}
