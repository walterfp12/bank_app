import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Entidad de usuario autenticado – capa Domain (Dart puro, sin dependencias externas)
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String image,
  }) = _AuthUser;
}
