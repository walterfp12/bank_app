import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../../services/http_client.dart';

/// Proveedores de infraestructura: dependencias externas que las capas Data
/// reciben inyectadas. Mantenerlas aquí evita que los DataSources llamen a
/// singletons globales y facilita sustituirlas en pruebas.

/// SharedPreferences – se sobreescribe en ProviderScope (main.dart).
/// Uso: caché no sensible (dashboard, idioma).
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('SharedPreferences no inicializado'),
);

/// Almacenamiento seguro cifrado (Keystore / Keychain) – HU 4.1.
/// Uso: token de sesión.
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

/// Firebase Authentication – HU 4.1
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

/// Cloud Firestore – HU 4.2
final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

/// Firebase Cloud Messaging – HU 4.3
final firebaseMessagingProvider = Provider<FirebaseMessaging>(
  (_) => FirebaseMessaging.instance,
);

/// Cliente HTTP Dio (se conserva para futuros servicios REST).
final httpClientProvider = Provider<AppHttpClient>(
  (_) => AppHttpClient(baseUrl: ApiConstants.baseUrl),
);
