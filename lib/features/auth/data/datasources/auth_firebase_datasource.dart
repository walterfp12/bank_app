import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../models/auth_session_model.dart';

/// DataSource remoto de autenticación – capa Data (HU 4.1).
///
/// Única clase de todo el proyecto que conoce `firebase_auth`. Traduce el
/// resultado de Firebase a [AuthSessionModel] y los errores de Firebase a las
/// excepciones del dominio ([AppException]).
abstract class AuthRemoteDataSource {
  Future<Result<AuthSessionModel>> login(String email, String password);
  Future<void> signOut();

  /// Sesión del usuario que Firebase mantiene activo entre reinicios.
  Future<AuthSessionModel?> currentSession();
}

class AuthFirebaseDataSource implements AuthRemoteDataSource {
  final FirebaseAuth _auth;

  const AuthFirebaseDataSource(this._auth);

  @override
  Future<Result<AuthSessionModel>> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return Result.failure(
          const UnknownException(message: 'Firebase no devolvió un usuario.'),
        );
      }

      return Result.success(await _toModel(user));
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseError(e));
    } on Exception catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<AuthSessionModel?> currentSession() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    try {
      return await _toModel(user);
    } on Exception {
      return null;
    }
  }

  /// Construye el modelo de sesión leyendo el idToken y su fecha real de
  /// expiración (Firebase emite tokens con 1 hora de vigencia).
  Future<AuthSessionModel> _toModel(User user) async {
    final tokenResult = await user.getIdTokenResult();

    return AuthSessionModel(
      userId: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL ?? '',
      accessToken: tokenResult.token ?? '',
      refreshToken: user.refreshToken ?? '',
      expiresAt: (tokenResult.expirationTime ??
              DateTime.now().add(const Duration(hours: 1)))
          .toIso8601String(),
    );
  }

  /// Traduce los códigos de Firebase a excepciones del dominio.
  AppException _mapFirebaseError(FirebaseAuthException e) {
    return switch (e.code) {
      'invalid-email' => const ValidationException(
          message: 'El correo no tiene un formato válido.',
        ),
      'user-disabled' => const ForbiddenException(
          message: 'Esta cuenta está deshabilitada.',
        ),
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' =>
        const UnauthorizedException(
          message: 'Correo o contraseña incorrectos.',
        ),
      'too-many-requests' => const ForbiddenException(
          message: 'Demasiados intentos. Espera un momento e intenta de nuevo.',
        ),
      'network-request-failed' => const NetworkException(),
      _ => UnknownException(
          message: e.message ?? 'No se pudo iniciar sesión.',
          originalError: e,
        ),
    };
  }
}
