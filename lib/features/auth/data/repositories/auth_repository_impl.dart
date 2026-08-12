import '../../../../core/errors/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase_datasource.dart';
import '../datasources/auth_secure_datasource.dart';
import '../models/auth_session_model.dart';

/// Implementación del repositorio de autenticación – capa Data (HU 4.1).
///
/// Orquesta dos fuentes:
/// - **remota**: Firebase Authentication (login / signOut / usuario actual)
/// - **local**: almacenamiento seguro cifrado (persistencia de la sesión)
///
/// El dominio solo ve entidades; los modelos y Firebase quedan encapsulados aquí.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  @override
  Future<Result<AuthSession>> login(String email, String password) async {
    final result = await _remote.login(email, password);

    if (result case Success<AuthSessionModel>(:final data)) {
      // Guarda la sesión cifrada antes de devolverla.
      await _local.saveSession(data);
      return Result.success(data.toDomain());
    }

    return Result.failure(result.errorOrNull!);
  }

  @override
  Future<Result<void>> logout() async {
    await _remote.signOut();
    return _local.clearSession();
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    // 1. Sesión guardada en el almacenamiento seguro.
    final cached = await _local.getSession();
    if (cached != null) return cached.toDomain();

    // 2. Firebase mantiene su propia sesión entre reinicios: si sigue activa,
    //    se reconstruye y se vuelve a guardar cifrada.
    final fromFirebase = await _remote.currentSession();
    if (fromFirebase != null) {
      await _local.saveSession(fromFirebase);
      return fromFirebase.toDomain();
    }

    return null;
  }
}
