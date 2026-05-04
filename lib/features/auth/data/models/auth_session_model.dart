import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// Modelo de sesión para persistencia en SharedPreferences – capa Data
/// Permite serializar/deserializar la sesión completa como JSON.
@freezed
class AuthSessionModel with _$AuthSessionModel {
  const factory AuthSessionModel({
    required int    userId,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String image,
    required String accessToken,
    required String refreshToken,
    required String expiresAt, // ISO 8601
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  const AuthSessionModel._();

  /// Convierte al modelo de dominio
  AuthSession toDomain() => AuthSession(
        user: AuthUser(
          id:        userId,
          username:  username,
          email:     email,
          firstName: firstName,
          lastName:  lastName,
          image:     image,
        ),
        accessToken:  accessToken,
        refreshToken: refreshToken,
        expiresAt:    DateTime.parse(expiresAt),
      );

  /// Construye desde la entidad de dominio
  static AuthSessionModel fromDomain(AuthSession session) => AuthSessionModel(
        userId:       session.user.id,
        username:     session.user.username,
        email:        session.user.email,
        firstName:    session.user.firstName,
        lastName:     session.user.lastName,
        image:        session.user.image,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
        expiresAt:    session.expiresAt.toIso8601String(),
      );
}
