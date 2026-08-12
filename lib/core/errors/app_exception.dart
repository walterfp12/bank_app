// HU 1.3 - Modelo de errores centralizado
// Jerarquia de excepciones para manejo uniforme de errores en toda la app

/// Excepcion base de la aplicacion
sealed class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException($code): $message';
}

/// Error de red / conectividad
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Error de conexión. Verifica tu internet.',
    super.code = 'NETWORK_ERROR',
    super.originalError,
  });
}

/// Error del servidor (5xx)
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    super.message = 'Error en el servidor. Intenta más tarde.',
    super.code = 'SERVER_ERROR',
    super.originalError,
    this.statusCode,
  });
}

/// Error de autenticación (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Sesión expirada. Inicia sesión nuevamente.',
    super.code = 'UNAUTHORIZED',
    super.originalError,
  });
}

/// Error de permisos (403)
class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'No tienes permisos para esta acción.',
    super.code = 'FORBIDDEN',
    super.originalError,
  });
}

/// Recurso no encontrado (404)
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Recurso no encontrado.',
    super.code = 'NOT_FOUND',
    super.originalError,
  });
}

/// Error de validación (422)
class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    super.message = 'Datos inválidos. Verifica la información.',
    super.code = 'VALIDATION_ERROR',
    super.originalError,
    this.fieldErrors,
  });
}

/// Timeout en la petición
class RequestTimeoutException extends AppException {
  const RequestTimeoutException({
    super.message = 'La solicitud tardó demasiado. Intenta de nuevo.',
    super.code = 'TIMEOUT',
    super.originalError,
  });
}

/// Error desconocido / genérico
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'Ha ocurrido un error inesperado.',
    super.code = 'UNKNOWN',
    super.originalError,
  });
}

/// Error de caché local
class CacheException extends AppException {
  const CacheException({
    super.message = 'Error al acceder a datos locales.',
    super.code = 'CACHE_ERROR',
    super.originalError,
  });
}

/// Fondos insuficientes (regla de negocio bancaria)
class InsufficientFundsException extends AppException {
  const InsufficientFundsException({
    super.message = 'Fondos insuficientes para realizar esta operación.',
    super.code = 'INSUFFICIENT_FUNDS',
    super.originalError,
  });
}

/// Texto listo para mostrarle al usuario.
///
/// `Exception.toString()` de un [AppException] incluye el prefijo técnico
/// (`AppException(CODE): ...`), que no debe llegar a la interfaz. Esta
/// extensión devuelve únicamente el mensaje legible.
extension AppExceptionMessage on Exception {
  String get friendlyMessage {
    final self = this;
    if (self is AppException) return self.message;
    return 'Ocurrió un error inesperado.';
  }
}
