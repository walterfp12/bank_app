import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/push_message.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/fcm_datasource.dart';

/// Implementación del repositorio de notificaciones – capa Data (HU 4.3).
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remote;

  const NotificationRepositoryImpl(this._remote);

  @override
  Future<Result<bool>> requestPermission() async {
    try {
      await _remote.initialize();
      return Result.success(await _remote.requestPermission());
    } on Exception catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  @override
  Future<Result<String>> getDeviceToken() async {
    try {
      final token = await _remote.getToken();
      if (token == null || token.isEmpty) {
        return Result.failure(
          const UnknownException(
            message: 'No se pudo obtener el token del dispositivo.',
          ),
        );
      }
      return Result.success(token);
    } on Exception catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  @override
  Stream<PushMessage> get messages => _remote.messages
      .map((event) => event.model.toDomain(origin: event.origin));
}
