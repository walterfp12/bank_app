import '../../../../core/errors/result.dart';
import '../entities/auth_session.dart';

/// Contrato abstracto del repositorio de autenticación – capa Domain.
///
/// El dominio no sabe si detrás hay Firebase, una API REST o un mock:
/// solo conoce esta interfaz. Por eso cambiar de DummyJSON a Firebase (HU 4.1)
/// no obligó a tocar casos de uso, estados ni pantallas.
abstract class AuthRepository {
  /// Inicia sesión con correo y contraseña.
  Future<Result<AuthSession>> login(String email, String password);

  /// Cierra la sesión y limpia el almacenamiento seguro.
  Future<Result<void>> logout();

  /// Retorna la sesión persistida, o null si no existe o expiró.
  Future<AuthSession?> getCurrentSession();
}
