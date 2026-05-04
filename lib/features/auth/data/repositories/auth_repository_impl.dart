import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_session_model.dart';

/// Implementación del repositorio de autenticación – capa Data
/// Orquesta remote datasource (DummyJSON/Dio) y local datasource (SharedPreferences).
/// Traduce modelos (LoginResponseModel → AuthSession) para que el dominio no dependa de red/storage.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource  _local;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource  local,
  })  : _remote = remote,
        _local  = local;

  @override
  Future<Result<AuthSession>> login(String username, String password) async {
    final result = await _remote.login(username, password);

    return result.map((model) {
      final session = AuthSession(
        user: AuthUser(
          id:        model.id,
          username:  model.username,
          email:     model.email,
          firstName: model.firstName,
          lastName:  model.lastName,
          image:     model.image,
        ),
        accessToken:  model.accessToken,
        refreshToken: model.refreshToken,
        // El tiempo de expiración se calcula localmente (2 min desde login)
        expiresAt: DateTime.now().add(
          const Duration(minutes: ApiConstants.tokenExpiresInMins),
        ),
      );
      // Persistir en background
      _local.saveSession(AuthSessionModel.fromDomain(session));
      return session;
    });
  }

  @override
  Future<Result<void>> logout() => _local.clearSession();

  @override
  Future<AuthSession?> getCurrentSession() async {
    final model = await _local.getSession();
    return model?.toDomain();
  }
}
