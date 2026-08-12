import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../models/auth_session_model.dart';

/// DataSource local de autenticación – capa Data (HU 4.1).
///
/// **Almacenamiento seguro de sesión**: usa `flutter_secure_storage`, que en
/// Android guarda los datos cifrados con la Keystore del sistema (y en iOS en
/// el Keychain). A diferencia de SharedPreferences, el token no queda en texto
/// plano dentro del sandbox de la app.
abstract class AuthLocalDataSource {
  Future<Result<void>> saveSession(AuthSessionModel session);
  Future<AuthSessionModel?> getSession();
  Future<Result<void>> clearSession();
}

class AuthSecureDataSource implements AuthLocalDataSource {
  final FlutterSecureStorage _storage;
  static const _sessionKey = 'bam_auth_session';

  const AuthSecureDataSource(this._storage);

  @override
  Future<Result<void>> saveSession(AuthSessionModel session) async {
    try {
      await _storage.write(
        key: _sessionKey,
        value: jsonEncode(session.toJson()),
      );
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(CacheException(originalError: e));
    }
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    try {
      final raw = await _storage.read(key: _sessionKey);
      if (raw == null) return null;

      final model = AuthSessionModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );

      // Sesión vencida: se descarta del almacenamiento seguro.
      if (model.toDomain().isExpired) {
        await _storage.delete(key: _sessionKey);
        return null;
      }
      return model;
    } on Exception {
      return null;
    }
  }

  @override
  Future<Result<void>> clearSession() async {
    try {
      await _storage.delete(key: _sessionKey);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(CacheException(originalError: e));
    }
  }
}
