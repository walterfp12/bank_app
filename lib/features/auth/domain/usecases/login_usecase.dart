import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: Login – capa Domain.
///
/// Valida las reglas de negocio antes de tocar el repositorio. Aquí no se sabe
/// que detrás hay Firebase.
class LoginUseCase {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);

  static final _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  Future<Result<AuthSession>> call(String email, String password) async {
    final normalized = email.trim().toLowerCase();

    if (normalized.isEmpty || password.isEmpty) {
      return Result.failure(
        const ValidationException(
          message: 'Correo y contraseña son requeridos.',
        ),
      );
    }

    if (!_emailRegex.hasMatch(normalized)) {
      return Result.failure(
        const ValidationException(message: 'Ingresa un correo válido.'),
      );
    }

    return _repository.login(normalized, password);
  }
}
