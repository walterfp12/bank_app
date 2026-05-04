import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_user.dart';

part 'auth_session.freezed.dart';

/// Entidad de sesión activa – capa Domain
@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required AuthUser user,
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) = _AuthSession;

  // Constructor privado requerido para métodos personalizados con Freezed
  const AuthSession._();

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isValid   => !isExpired && accessToken.isNotEmpty;

  Duration get timeUntilExpiry => expiresAt.difference(DateTime.now());
}
