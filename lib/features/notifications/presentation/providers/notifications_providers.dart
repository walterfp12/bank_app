import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/infrastructure_providers.dart';
import '../../data/datasources/fcm_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/get_device_token_usecase.dart';
import '../../domain/usecases/request_notification_permission_usecase.dart';

/// Inyección de dependencias del feature notifications (HU 4.3).

final localNotificationsProvider = Provider<FlutterLocalNotificationsPlugin>(
  (_) => FlutterLocalNotificationsPlugin(),
);

// ─── Data ─────────────────────────────────────────────────────────────────────

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>((ref) {
  final dataSource = FcmDataSource(
    messaging: ref.read(firebaseMessagingProvider),
    localNotifications: ref.read(localNotificationsProvider),
  );
  ref.onDispose(dataSource.dispose);
  return dataSource;
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    ref.read(notificationRemoteDataSourceProvider),
  );
});

// ─── Domain – Use Cases ───────────────────────────────────────────────────────

final requestNotificationPermissionUseCaseProvider =
    Provider<RequestNotificationPermissionUseCase>((ref) {
  return RequestNotificationPermissionUseCase(
    ref.read(notificationRepositoryProvider),
  );
});

final getDeviceTokenUseCaseProvider = Provider<GetDeviceTokenUseCase>((ref) {
  return GetDeviceTokenUseCase(ref.read(notificationRepositoryProvider));
});
