# Arquitectura del Feature Auth – BAM Wallet

## Clean Architecture (4 capas)

```
┌──────────────────────────────────────────────────┐
│              PRESENTATION LAYER                  │
│  widgets/  │  states/  │  controllers/  │ screens │
│  LoginHeader, LoginForm, LoginButton             │
│  AuthState (sealed): Idle/Loading/Auth/Error     │
│  AuthController (ChangeNotifier)                 │
└──────────────────┬───────────────────────────────┘
                   │ (sólo conoce Application)
┌──────────────────▼───────────────────────────────┐
│              APPLICATION LAYER                   │
│               services/                          │
│  AuthService   – fachada de casos de uso         │
│  SessionService – ciclo de vida de sesión        │
└──────────────────┬───────────────────────────────┘
                   │ (sólo conoce Domain)
┌──────────────────▼───────────────────────────────┐
│                DOMAIN LAYER                      │
│  models/        repositories/    usecases/       │
│  AuthUser       AuthRepository   LoginUseCase    │
│  AuthSession    (abstracto)      LogoutUseCase   │
│                                  GetCurrentSession│
└──────────────────┬───────────────────────────────┘
                   │ (implementa contratos Domain)
┌──────────────────▼───────────────────────────────┐
│                 DATA LAYER                       │
│  dtos/          datasources/     repositories/   │
│  AuthUserDto    AuthRemoteDS     AuthRepoImpl    │
│  AuthSessionDto AuthLocalDS                      │
│  LoginRequestDto (SharedPrefs)                   │
│                 (Dio/AppHttpClient)               │
└──────────────────────────────────────────────────┘
```

## Reglas de dependencias (Clean Architecture)

- **Domain** → sin imports externos (Dart puro). Cero Flutter, cero Dio.
- **Data** → conoce Domain. Traduce DTO ↔ Entidad. Usa Dio y SharedPreferences.
- **Application** → conoce Domain. Orquesta Use Cases. No conoce UI ni datasources.
- **Presentation** → consume sólo Application (via AuthController/AuthService). No llama repositorios directamente.

Las dependencias apuntan **siempre hacia adentro** (Presentation → Application → Domain ← Data).

## Flujo de login

```
LoginScreen
  → _handleLogin()
  → AuthController.login(email, password)
     → AuthService.login()
        → LoginUseCase.call()
           → AuthRepository.login()            ← contrato Domain
              → AuthRepositoryImpl             ← implementación Data
                 → AuthRemoteDataSource.login()
                    → (mock / Dio POST /auth/login)
                    ← AuthSessionDto
                 → AuthLocalDataSource.saveSession()
                 ← AuthSession (entidad Domain)
           ← Result<AuthSession>
        ← Result<AuthSession>
     ← Result<AuthSession>
  → _emit(AuthAuthenticated(session))
  → notifyListeners() → GoRouter.redirect → /dashboard
```

## Flujo de restauración de sesión (arranque)

```
main()
  → authController.tryRestoreSession()
     → SessionService.tryRestoreSession()
        → GetCurrentSessionUseCase.call()
           → AuthRepositoryImpl.getCurrentSession()
              → AuthLocalDataSource.getSession()
                 → SharedPreferences.getString('auth_session')
                 → si expirada: clearSession() → null
                 ← AuthSessionDto o null
              ← AuthSession o null
           ← AuthSession o null
     ← AuthSession o null
  → _emit(AuthAuthenticated) o _emit(AuthIdle)
  → runApp(...)  ← GoRouter ya sabe si hay sesión activa
```

## Guard de rutas (HU 2.3)

GoRouter usa `refreshListenable: authController`. Cada vez que `AuthController` emite `notifyListeners()`, el redirect se re-evalúa:

| Estado | Ruta destino | Resultado |
|---|---|---|
| No autenticado | `/dashboard` (protegida) | Redirige → `/login` |
| Autenticado | `/login` | Redirige → `/dashboard` |
| Cualquiera | Ruta pública (`/login`) | Sin redirección |

## Decisiones técnicas

| Decisión | Motivo |
|---|---|
| `sealed class AuthState` | Exhaustividad garantizada en switch/when; imposible estado inconsistente |
| `ChangeNotifier` como Controller | Compatible con `provider` (ya usado) y `refreshListenable` de GoRouter |
| Application Layer separada | Cumple la arquitectura de referencia (imagen del curso). Desacopla UI de UseCase |
| DTOs con `toDomain()` | Traducción explícita; el dominio nunca depende de modelos de red o storage |
| Mock en RemoteDataSource | Preparado para swap con Firebase Auth en HU 4.1 sin tocar capas superiores |

## Preparación para HU 4.1 (Firebase Auth)

Solo se reemplaza `AuthRemoteDataSourceImpl`. Las capas Domain, Application y Presentation **no cambian**.

```dart
// Cambio aislado en data/datasources/auth_remote_datasource.dart:
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Reemplazar mock por: FirebaseAuth.instance.signInWithEmailAndPassword(...)
}
```
