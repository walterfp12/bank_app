import '../../../../core/errors/result.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: Logout – capa Domain
class LogoutUseCase {
  final AuthRepository _repository;
  const LogoutUseCase(this._repository);

  Future<Result<void>> call() async => _repository.logout();
}
