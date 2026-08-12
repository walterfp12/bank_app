import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../domain/entities/push_message.dart';
import '../models/push_message_model.dart';

/// Identificador del canal declarado en AndroidManifest.xml.
const kNotificationChannelId = 'bam_wallet_channel';

/// DataSource de notificaciones – capa Data (HU 4.3).
///
/// Única clase que conoce `firebase_messaging` y `flutter_local_notifications`.
///
/// Detalle importante: cuando la app está en **primer plano**, Android NO
/// muestra la notificación automáticamente. Por eso, al recibir un mensaje, se
/// dispara una notificación local para que el usuario la vea igual.
abstract interface class NotificationRemoteDataSource {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<String?> getToken();
  Stream<({PushMessageModel model, PushOrigin origin})> get messages;
}

class FcmDataSource implements NotificationRemoteDataSource {
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  final _controller =
      StreamController<({PushMessageModel model, PushOrigin origin})>.broadcast();

  bool _initialized = false;

  FcmDataSource({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
  })  : _messaging = messaging,
        _localNotifications = localNotifications;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    await _setupLocalNotifications();

    // App en primer plano: FCM entrega el mensaje pero no lo muestra.
    FirebaseMessaging.onMessage.listen((message) {
      final model = PushMessageModel.fromRemoteMessage(message);
      _showLocalNotification(model);
      _controller.add((model: model, origin: PushOrigin.foreground));
    });

    // El usuario tocó la notificación y la app pasó a primer plano.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _controller.add((
        model: PushMessageModel.fromRemoteMessage(message),
        origin: PushOrigin.opened,
      ));
    });

    // La app estaba cerrada y se abrió desde la notificación.
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _controller.add((
        model: PushMessageModel.fromRemoteMessage(initial),
        origin: PushOrigin.opened,
      ));
    }
  }

  /// Crea el canal de Android y prepara el plugin de notificaciones locales.
  Future<void> _setupLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _localNotifications.initialize(settings: settings);

    const channel = AndroidNotificationChannel(
      kNotificationChannelId,
      'Notificaciones BAM Wallet',
      description: 'Alertas de movimientos y avisos de la cuenta',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _showLocalNotification(PushMessageModel model) async {
    if (model.title.isEmpty && model.body.isEmpty) return;

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        kNotificationChannelId,
        'Notificaciones BAM Wallet',
        channelDescription: 'Alertas de movimientos y avisos de la cuenta',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    await _localNotifications.show(
      id: model.id.hashCode & 0x7FFFFFFF,
      title: model.title.isEmpty ? 'BAM Wallet' : model.title,
      body: model.body,
      notificationDetails: details,
    );
  }

  @override
  Future<bool> requestPermission() async {
    // Permiso de FCM (Android 13+ / iOS).
    final settings = await _messaging.requestPermission();

    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;

    // El plugin local necesita su propia solicitud en Android 13+.
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return granted;
  }

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  Stream<({PushMessageModel model, PushOrigin origin})> get messages =>
      _controller.stream;

  void dispose() => _controller.close();
}

/// Handler de mensajes en segundo plano.
///
/// Debe ser una función de nivel superior con `@pragma('vm:entry-point')`:
/// Flutter la ejecuta en un isolate aparte cuando la app no está en memoria.
/// Android muestra la notificación por su cuenta en este escenario.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Sin trabajo pesado aquí: la notificación la despliega el sistema.
}
