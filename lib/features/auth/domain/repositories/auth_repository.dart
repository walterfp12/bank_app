import '../../../../core/errors/result.dart';
import '../entities/auth_session.dart';

/// Contrato abstracto del repositorio de autenticación – capa Domain
abstract class AuthRepository {
  /// Inicia sesión con username y contraseña (DummyJSON usa username)
  Future<Result<AuthSession>> login(String username, String password);

  /// Cierra la sesión y limpia la persistencia local
  Future<Result<void>> logout();

  /// Retorna la sesión persistida localmente, o null si no existe / expiró
  Future<AuthSession?> getCurrentSession();
}
