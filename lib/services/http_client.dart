import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../core/errors/app_exception.dart';
import '../core/errors/result.dart';

/// HU 1.3 – Cliente HTTP reutilizable con interceptores
/// Manejo centralizado de peticiones, errores, headers y tokens
///
/// Uso:
/// ```dart
/// final client = HttpClient(baseUrl: 'https://api.example.com');
/// final result = await client.get<Map>('/accounts');
/// result.when(
///   success: (data) => print(data),
///   failure: (error) => print(error),
/// );
/// ```
class AppHttpClient {
  final String baseUrl;
  final http.Client _client;
  final Duration timeout;
  String? _authToken;

  // Interceptores: callbacks para logging, analytics, etc.
  final List<void Function(http.BaseRequest request)> _requestInterceptors = [];
  final List<void Function(http.Response response)> _responseInterceptors = [];

  AppHttpClient({
    required this.baseUrl,
    http.Client? client,
    this.timeout = const Duration(seconds: 30),
  }) : _client = client ?? http.Client();

  /// Configurar token de autenticación
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// Agregar interceptor de request
  void addRequestInterceptor(void Function(http.BaseRequest request) interceptor) {
    _requestInterceptors.add(interceptor);
  }

  /// Agregar interceptor de response
  void addResponseInterceptor(void Function(http.Response response) interceptor) {
    _responseInterceptors.add(interceptor);
  }

  /// Headers por defecto
  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  // ─── Métodos HTTP ────────────────────────────────────

  /// GET request
  Future<Result<T>> get<T>(
    String path, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) async {
    return _executeRequest(
      () {
        final uri = _buildUri(path, queryParams);
        return _client.get(uri, headers: {..._defaultHeaders, ...?headers});
      },
      fromJson: fromJson,
    );
  }

  /// POST request
  Future<Result<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) async {
    return _executeRequest(
      () {
        final uri = _buildUri(path);
        return _client.post(
          uri,
          headers: {..._defaultHeaders, ...?headers},
          body: body != null ? jsonEncode(body) : null,
        );
      },
      fromJson: fromJson,
    );
  }

  /// PUT request
  Future<Result<T>> put<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) async {
    return _executeRequest(
      () {
        final uri = _buildUri(path);
        return _client.put(
          uri,
          headers: {..._defaultHeaders, ...?headers},
          body: body != null ? jsonEncode(body) : null,
        );
      },
      fromJson: fromJson,
    );
  }

  /// DELETE request
  Future<Result<T>> delete<T>(
    String path, {
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) async {
    return _executeRequest(
      () {
        final uri = _buildUri(path);
        return _client.delete(uri, headers: {..._defaultHeaders, ...?headers});
      },
      fromJson: fromJson,
    );
  }

  // ─── Internos ────────────────────────────────────────

  Uri _buildUri(String path, [Map<String, String>? queryParams]) {
    final uri = Uri.parse('$baseUrl$path');
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  Future<Result<T>> _executeRequest<T>(
    Future<http.Response> Function() request, {
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final response = await request().timeout(timeout);

      // Ejecutar interceptores de response
      for (final interceptor in _responseInterceptors) {
        interceptor(response);
      }

      // Verificar código de estado
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return Result.success(null as T);
        }
        final decoded = jsonDecode(response.body);
        if (fromJson != null) {
          return Result.success(fromJson(decoded));
        }
        return Result.success(decoded as T);
      }

      // Mapear errores HTTP a excepciones
      throw _mapStatusCodeToException(response);
    } on AppException {
      rethrow;
    } on SocketException catch (e) {
      return Result.failure(NetworkException(originalError: e));
    } on TimeoutException catch (e) {
      return Result.failure(
        RequestTimeoutException(originalError: e),
      );
    } on FormatException catch (e) {
      return Result.failure(
        UnknownException(
          message: 'Error al procesar la respuesta del servidor.',
          originalError: e,
        ),
      );
    } catch (e) {
      return Result.failure(UnknownException(originalError: e));
    }
  }

  AppException _mapStatusCodeToException(http.Response response) {
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    final message = body is Map ? body['message'] as String? : null;

    return switch (response.statusCode) {
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
          statusCode: response.statusCode,
          message: message ?? 'Error en el servidor.',
        ),
      _ => UnknownException(
          message: message ?? 'Error HTTP ${response.statusCode}',
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
        (value is List) ? value.map((e) => e.toString()).toList() : [value.toString()],
      ),
    );
  }

  /// Cerrar cliente
  void dispose() {
    _client.close();
  }
}
