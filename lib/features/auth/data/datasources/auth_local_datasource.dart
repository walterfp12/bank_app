import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../models/auth_session_model.dart';

/// DataSource local de autenticación – capa Data
/// Persiste la sesión en SharedPreferences usando AuthSessionModel (Freezed + JSON).
abstract class AuthLocalDataSource {
  Future<Result<void>> saveSession(AuthSessionModel session);
  Future<AuthSessionModel?> getSession();
  Future<Result<void>> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;
  static const _sessionKey = 'bam_auth_session';

  const AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<Result<void>> saveSession(AuthSessionModel session) async {
    try {
      await _prefs.setString(_sessionKey, jsonEncode(session.toJson()));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheException(originalError: e));
    }
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    try {
      final raw = _prefs.getString(_sessionKey);
      if (raw == null) return null;
      final model = AuthSessionModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      // Eliminar sesión expirada automáticamente
      if (model.toDomain().isExpired) {
        await _prefs.remove(_sessionKey);
        return null;
      }
      return model;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<void>> clearSession() async {
    try {
      await _prefs.remove(_sessionKey);
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheException(originalError: e));
    }
  }
}
