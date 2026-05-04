import '../../../../core/errors/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

/// Servicio de autenticación – capa Application
/// Fachada entre Presentation y los casos de uso de dominio.
class AuthService {
  final LoginUseCase  _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  const AuthService({
    required LoginUseCase  loginUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase  = loginUseCase,
        _logoutUseCase = logoutUseCase;

  Future<Result<AuthSession>> login(String username, String password) =>
      _loginUseCase(username, password);

  Future<Result<void>> logout() => _logoutUseCase();
}
