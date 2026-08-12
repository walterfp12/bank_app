import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// Modelo de sesión – capa Data (Freezed + JSON).
///
/// Es lo que se serializa hacia el almacenamiento seguro (HU 4.1) y lo que
/// produce el DataSource de Firebase. `toDomain()` lo convierte en entidad.
@freezed
class AuthSessionModel with _$AuthSessionModel {
  const AuthSessionModel._();

  const factory AuthSessionModel({
    /// uid de Firebase
    required String userId,
    required String email,
    @Default('') String displayName,
    @Default('') String photoUrl,
    required String accessToken,
    @Default('') String refreshToken,
    required String expiresAt, // ISO 8601
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  AuthSession toDomain() => AuthSession(
        user: AuthUser(
          id: userId,
          email: email,
          displayName: displayName,
          photoUrl: photoUrl,
        ),
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresAt: DateTime.parse(expiresAt),
      );

  static AuthSessionModel fromDomain(AuthSession session) => AuthSessionModel(
        userId: session.user.id,
        email: session.user.email,
        displayName: session.user.displayName,
        photoUrl: session.user.photoUrl,
        accessToken: session.accessToken,
        refreshToken: session.refreshToken,
        expiresAt: session.expiresAt.toIso8601String(),
      );
}
