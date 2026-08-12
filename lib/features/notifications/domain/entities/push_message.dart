import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_message.freezed.dart';

/// Origen desde el que llegó la notificación.
enum PushOrigin {
  /// Recibida con la app abierta.
  foreground,

  /// El usuario tocó la notificación y abrió la app.
  opened,
}

/// Entidad de notificación push – capa Domain (HU 4.3).
///
/// Es el modelo interno de la app: no depende de `RemoteMessage` de Firebase.
@freezed
class PushMessage with _$PushMessage {
  const PushMessage._();

  const factory PushMessage({
    required String id,
    required String title,
    required String body,
    required DateTime receivedAt,
    @Default(PushOrigin.foreground) PushOrigin origin,
    @Default(<String, String>{}) Map<String, String> data,
  }) = _PushMessage;

  /// True si el mensaje trae contenido mostrable.
  bool get hasContent => title.isNotEmpty || body.isNotEmpty;
}
