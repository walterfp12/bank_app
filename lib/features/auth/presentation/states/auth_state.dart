import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_session.dart';

part 'auth_state.freezed.dart';

/// Estados de autenticación – capa Presentation (Freezed sealed class)
///
/// Uso con pattern matching:
/// ```dart
/// state.when(
///   initial: () => ...,
///   loading: () => ...,
///   authenticated: (session) => ...,
///   error: (message) => ...,
/// );
/// ```
@freezed
sealed class AuthState with _$AuthState {
  /// Estado inicial / sin sesión
  const factory AuthState.initial() = AuthStateInitial;

  /// Operación en curso (login / logout / restore)
  const factory AuthState.loading() = AuthStateLoading;

  /// Usuario autenticado exitosamente
  const factory AuthState.authenticated({required AuthSession session}) =
      AuthStateAuthenticated;

  /// Error durante autenticación
  const factory AuthState.error({required String message}) = AuthStateError;
}
