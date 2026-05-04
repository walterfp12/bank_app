import 'package:dio/dio.dart';
import '../core/errors/app_exception.dart';
import '../core/errors/result.dart';

/// HU 1.3 – Cliente HTTP reutilizable construido sobre Dio
/// Interceptores de autenticación, logging y manejo de errores centralizado.
///
/// Uso:
/// ```dart
/// final client = AppHttpClient(baseUrl: 'https://api.example.com');
/// final result = await client.get<Map>('/accounts');
/// result.when(
///   success: (data) => print(data),
///   failure: (error) => print(error),
/// );
/// ```
class AppHttpClient {
  final String baseUrl;
  final Duration timeout;

  late final Dio _dio;

  AppHttpClient({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(this),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  String? _authToken;

  /// Configurar token de autenticación (inyectado en cada request)
  void setAuthToken(String? token) => _authToken = token;

  // ─── Métodos HTTP ─────────────────────────────────────────────────────────

  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    T Function(Object? json)? fromJson,
  }) async {
    return _execute(
      () => _dio.get<Object?>(
        path,
        queryParameters: queryParams,
        options: Options(headers: headers),
      ),
      fromJson: fromJson,
    );
  }

  Future<Result<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
    T Function(Object? json)? fromJson,
  }) async {
    return _execute(
      () => _dio.post<Object?>(
        path,
        data: body,
        options: Options(headers: headers),
      ),
      fromJson: fromJson,
    );
  }

  Future<Result<T>> put<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
    T Function(Object? json)? fromJson,
  }) async {
    return _execute(
      () => _dio.put<Object?>(
        path,
        data: body,
        options: Options(headers: headers),
      ),
      fromJson: fromJson,
    );
  }

  Future<Result<T>> delete<T>(
    String path, {
    Map<String, dynamic>? headers,
    T Function(Object? json)? fromJson,
  }) async {
    return _execute(
      () => _dio.delete<Object?>(
        path,
        options: Options(headers: headers),
      ),
      fromJson: fromJson,
    );
  }

  // ─── Interno ──────────────────────────────────────────────────────────────

  Future<Result<T>> _execute<T>(
    Future<Response<Object?>> Function() request, {
    T Function(Object? json)? fromJson,
  }) async {
    try {
      final response = await request();
      final data = response.data;
      if (fromJson != null && data != null) {
        return Result.success(fromJson(data));
      }
      return Result.success(data as T);
    } on AppException catch (e) {
      return Result.failure(e);
    } on DioException catch (e) {
      return Result.failure(_mapDioException(e));
    } catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  AppException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return RequestTimeoutException(originalError: e);

      case DioExceptionType.connectionError:
        return NetworkException(originalError: e);

      case DioExceptionType.badResponse:
        return _mapStatusCode(e.response);

      case DioExceptionType.cancel:
        return UnknownException(
          message: 'La solicitud fue cancelada.',
          originalError: e,
        );

      default:
        return UnknownException(originalError: e);
    }
  }

  AppException _mapStatusCode(Response<Object?>? response) {
    if (response == null) return const NetworkException();

    final statusCode = response.statusCode ?? 0;
    final body = response.data;
    final message = body is Map ? body['message'] as String? : null;

    return switch (statusCode) {
      401 => UnauthorizedException(
          message: message ?? 'Sesión expirada. Inicia sesión nuevamente.',
        ),
      403 => ForbiddenException(
          message: message ?? 'No tienes permisos para esta acción.',
        ),
      404 => NotFoundException(
          message: message ?? 'Recurso no encontrado.',
        ),
      422 => ValidationException(
          message: message ?? 'Datos inválidos.',
          fieldErrors: _parseFieldErrors(body),
        ),
      >= 500 => ServerException(
          statusCode: statusCode,
          message: message ?? 'Error en el servidor.',
        ),
      _ => UnknownException(
          message: message ?? 'Error HTTP $statusCode',
        ),
    };
  }

  Map<String, List<String>>? _parseFieldErrors(dynamic body) {
    if (body is! Map || !body.containsKey('errors')) return null;
    final errors = body['errors'];
    if (errors is! Map) return null;
    return errors.map(
      (key, value) => MapEntry(
        key.toString(),
        (value is List)
            ? value.map((e) => e.toString()).toList()
            : [value.toString()],
      ),
    );
  }
}

// ─── Interceptores ────────────────────────────────────────────────────────────

/// Inyecta Bearer token en cada request si está disponible
class _AuthInterceptor extends Interceptor {
  final AppHttpClient client;
  _AuthInterceptor(this.client);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (client._authToken != null) {
      options.headers['Authorization'] = 'Bearer ${client._authToken}';
    }
    handler.next(options);
  }
}

/// Log de request y response en modo debug
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    assert(() {
      // ignore: avoid_print
      print('[DIO] → ${options.method} ${options.uri}');
      return true;
    }());
    handler.next(options);
  }

  @override
  void onResponse(Response<Object?> response, ResponseInterceptorHandler handler) {
    assert(() {
      // ignore: avoid_print
      print('[DIO] ← ${response.statusCode} ${response.requestOptions.uri}');
      return true;
    }());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    assert(() {
      // ignore: avoid_print
      print('[DIO] ✗ ${err.type} ${err.requestOptions.uri}');
      return true;
    }());
    handler.next(err);
  }
}

/// Convierte DioException en AppException antes de que salga del interceptor
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Dejamos que _execute maneje el mapeo; solo hacemos pass-through
    handler.next(err);
  }
}
