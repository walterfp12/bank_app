import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: Login – capa Domain
class LoginUseCase {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);

  Future<Result<AuthSession>> call(String username, String password) async {
    if (username.trim().isEmpty || password.trim().isEmpty) {
      return Result.failure(
        const ValidationException(message: 'Usuario y contraseña son requeridos.'),
      );
    }
    return _repository.login(username.trim(), password);
  }
}
