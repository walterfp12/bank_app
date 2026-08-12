import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/push_message.dart';

part 'push_message_model.freezed.dart';
part 'push_message_model.g.dart';

/// Modelo de notificación – capa Data (Freezed + JSON) (HU 4.3).
///
/// Traduce el `RemoteMessage` de Firebase al modelo interno. La entidad de
/// dominio nunca ve tipos de `firebase_messaging`.
@freezed
class PushMessageModel with _$PushMessageModel {
  const PushMessageModel._();

  const factory PushMessageModel({
    required String id,
    @Default('') String title,
    @Default('') String body,
    required DateTime receivedAt,
    @Default(<String, String>{}) Map<String, String> data,
  }) = _PushMessageModel;

  factory PushMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PushMessageModelFromJson(json);

  /// Construye el modelo desde el mensaje que entrega FCM.
  factory PushMessageModel.fromRemoteMessage(RemoteMessage message) {
    final notification = message.notification;

    return PushMessageModel(
      id: message.messageId ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      // Si el push viene solo con `data` (sin bloque notification),
      // se usan las claves title/body del payload.
      title: notification?.title ?? message.data['title']?.toString() ?? '',
      body: notification?.body ?? message.data['body']?.toString() ?? '',
      receivedAt: message.sentTime ?? DateTime.now(),
      data: message.data.map((k, v) => MapEntry(k, v.toString())),
    );
  }

  PushMessage toDomain({required PushOrigin origin}) => PushMessage(
        id: id,
        title: title,
        body: body,
        receivedAt: receivedAt,
        origin: origin,
        data: data,
      );
}
