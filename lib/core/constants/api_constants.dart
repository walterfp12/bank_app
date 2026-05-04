/// Constantes de la API – HU 1.3 / HU 2.2
/// Centraliza todas las URLs y configuraciones de red.
class ApiConstants {
  ApiConstants._();

  // ─── Base ────────────────────────────────────────────────────────────────
  static const String baseUrl = 'https://dummyjson.com';

  // ─── Auth ────────────────────────────────────────────────────────────────
  static const String loginEndpoint    = '/auth/login';
  static const String meEndpoint       = '/auth/me';
  static const String refreshEndpoint  = '/auth/refresh';

  // ─── Configuración de tokens ─────────────────────────────────────────────
  /// Tiempo de vida del access token en minutos (2 min para demo de expiración)
  static const int tokenExpiresInMins = 2;
}
