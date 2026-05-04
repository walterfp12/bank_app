import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../services/http_client.dart';
import '../models/login_response_model.dart';

/// DataSource remoto de autenticación – capa Data
/// Consume la API de DummyJSON usando Dio (via AppHttpClient).
/// Ref: https://dummyjson.com/docs/auth
abstract class AuthRemoteDataSource {
  Future<Result<LoginResponseModel>> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AppHttpClient _httpClient;
  const AuthRemoteDataSourceImpl(this._httpClient);

  @override
  Future<Result<LoginResponseModel>> login(
    String username,
    String password,
  ) async {
    return _httpClient.post<LoginResponseModel>(
      ApiConstants.loginEndpoint,
      body: {
        'username': username,
        'password': password,
        // Token expira en 2 minutos para demostrar expiración de sesión
        'expiresInMins': ApiConstants.tokenExpiresInMins,
      },
      fromJson: (json) =>
          LoginResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
