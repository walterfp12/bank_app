import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Entidad de usuario autenticado – capa Domain (Dart puro, sin dependencias externas).
///
/// HU 4.1 – Los campos corresponden a lo que expone Firebase Authentication
/// (uid, email, displayName, photoURL), pero la entidad NO conoce Firebase:
/// el mapeo ocurre en la capa Data.
@freezed
class AuthUser with _$AuthUser {
  const AuthUser._();

  const factory AuthUser({
    /// uid de Firebase
    required String id,
    required String email,
    @Default('') String displayName,
    @Default('') String photoUrl,
  }) = _AuthUser;

  /// Nombre a mostrar; si no hay displayName usa la parte local del correo.
  String get name =>
      displayName.isNotEmpty ? displayName : email.split('@').first;

  /// Iniciales para el avatar.
  String get initials {
    final parts =
        name.trim().split(RegExp(r'[\s._-]+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts[1].substring(0, 1))
        .toUpperCase();
  }
}
