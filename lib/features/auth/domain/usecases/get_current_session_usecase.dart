import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: Obtener sesión activa – capa Domain
class GetCurrentSessionUseCase {
  final AuthRepository _repository;
  const GetCurrentSessionUseCase(this._repository);

  Future<AuthSession?> call() async => _repository.getCurrentSession();
}
