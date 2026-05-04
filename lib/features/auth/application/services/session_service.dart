import '../../domain/entities/auth_session.dart';
import '../../domain/usecases/get_current_session_usecase.dart';

/// Servicio de sesión – capa Application
/// Maneja el ciclo de vida de la sesión: restaurar al arrancar la app.
class SessionService {
  final GetCurrentSessionUseCase _getCurrentSession;

  const SessionService({required GetCurrentSessionUseCase getCurrentSession})
      : _getCurrentSession = getCurrentSession;

  Future<AuthSession?> tryRestoreSession() => _getCurrentSession();
}
