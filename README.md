# BAM Wallet & Transfers

**Módulo Bancario Escalable** – Proyecto transversal del curso Flutter Avanzado.

---

## Descripción

Aplicación bancaria móvil que simula un módulo real de una app financiera de alto tráfico.
Incluye autenticación con Clean Architecture, visualización de productos/saldos, transferencias, historial de transacciones y configuración.

---

## Tecnologías

| Tecnología | Versión | Uso |
|---|---|---|
| Flutter | 3.41.1 | Framework UI multiplataforma |
| Dart | 3.11.0 | Lenguaje de programación |
| go_router | ^14.8.1 | Navegación declarativa con route guards |
| flutter_riverpod | ^2.6.1 | Manejo de estado reactivo |
| freezed_annotation | ^2.4.4 | Clases selladas e inmutables |
| json_annotation | ^4.9.0 | Serialización JSON |
| dio | ^5.7.0 | Cliente HTTP con interceptores |
| shared_preferences | ^2.5.3 | Persistencia de sesión local |
| google_fonts | ^6.2.1 | Tipografía Inter |
| intl | ^0.20.2 | Formateo i18n (fechas, moneda) |
| animations | ^2.0.11 | Animaciones Material |
| flutter_svg | ^2.0.17 | Soporte SVG |

### Dev Dependencies

| Paquete | Versión | Uso |
|---|---|---|
| build_runner | ^2.4.14 | Generación de código |
| freezed | ^2.5.7 | Generador de clases Freezed |
| json_serializable | ^6.8.0 | Generador de serialización JSON |

---

## Plataformas Soportadas

- Android
- iOS
- Web

---

## Arquitectura — Clean Architecture (4 capas)

El proyecto implementa **Clean Architecture** estricta por features:

```
lib/features/auth/
├── presentation/       # Capa UI
│   ├── screens/        # Pantallas (LoginScreen)
│   ├── widgets/        # Componentes (LoginForm, LoginButton, LoginHeader)
│   ├── controllers/    # AuthController (Riverpod Notifier)
│   ├── states/         # AuthState (Freezed sealed class)
│   └── providers/      # RouterNotifier, auth_providers
├── application/        # Capa de Aplicación
│   └── services/       # AuthService, SessionService
├── domain/             # Capa de Dominio
│   ├── entities/       # AuthUser, AuthSession (Freezed)
│   ├── repositories/   # Contrato IAuthRepository
│   └── usecases/       # LoginUseCase, LogoutUseCase, GetCurrentSessionUseCase
└── data/               # Capa de Datos
    ├── datasources/    # AuthRemoteDataSource, AuthLocalDataSource
    ├── models/         # LoginResponseModel, AuthSessionModel (Freezed + JSON)
    └── repositories/   # AuthRepositoryImpl
```

### Flujo de dependencias

```
Presentation  →  Application  →  Domain  ←  Data
(Riverpod)       (Services)     (Entities)   (Dio + SharedPrefs)
```

---

## Estructura del Proyecto

```
lib/
├── core/
│   ├── constants/          # AppColors, AppDimens, ApiConstants
│   ├── errors/             # Modelo de errores centralizado
│   ├── providers/          # infrastructure_providers (SharedPrefs, HttpClient)
│   ├── theme/              # Tema Material 3
│   └── utils/              # Validators, formatters
├── features/
│   ├── auth/               # Autenticación — Clean Architecture completa
│   ├── agent/              # Pantalla Agente IA (AgentChatScreen)
│   ├── home/               # Dashboard
│   ├── transactions/       # Transferencias e historial
│   └── profile/            # Configuración / Settings
├── routes/                 # app_router.dart (GoRouter + RouterNotifier)
├── services/               # HttpClient (Dio), MockDataService
└── main.dart               # Entry point con ProviderScope
```

---

## Configuración y Ejecución

### Prerrequisitos

- Flutter SDK >= 3.41.0
- Dart >= 3.11.0
- Android Studio / Xcode (para móvil)
- Chrome (para web)

### Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/walterfp12/bank_app.git
cd bank_app

# 2. Instalar dependencias
flutter pub get

# 3. Generar código de Freezed y JSON (requerido)
dart run build_runner build --delete-conflicting-outputs

# 4. Ejecutar la app
flutter run                 # Dispositivo conectado
flutter run -d chrome       # Web
flutter run -d ios          # iOS
flutter run -d android      # Android
```

> **Nota Android (Java):** Si hay incompatibilidad con Java 25, usar Java 21:
> ```bash
> JAVA_HOME="/path/to/java-21" flutter run -d <device-id>
> ```

### Verificar el proyecto

```bash
flutter analyze             # Análisis estático
flutter test                # Ejecutar pruebas
flutter doctor              # Verificar entorno
```

---

## Autenticación — HU 2.x

### Credenciales de prueba (DummyJSON API)

| Campo | Valor |
|---|---|
| Usuario | `emilys` |
| Contraseña | `emilyspass` |

> La sesión expira automáticamente a los **2 minutos** y redirige al login (HU 2.3).
> API utilizada: `https://dummyjson.com/auth/login`

### Flujo de sesión

```
Login → DummyJSON API (Dio) → Token JWT → SharedPreferences
                                              ↓
                                    Timer 2 min → Auto logout
                                              ↓
                                    GoRouter guard → /login
```

### Cliente HTTP — Dio

`AppHttpClient` configurado con tres interceptores:
- `AuthInterceptor` — adjunta el token Bearer a cada request
- `LoggingInterceptor` — logs de request/response en debug
- `ErrorInterceptor` — mapea `DioException` a `AppException` del dominio

---

## Backlog del Proyecto

| Módulo | HU | Descripción | Estado |
|---|---|---|---|
| 1 - Fundamentos | HU 1.1 | Config profesional + Material 3 | ✅ |
| 1 - Fundamentos | HU 1.2 | Navegación base (GoRouter + Shell) | ✅ |
| 1 - Fundamentos | HU 1.3 | Cliente HTTP (Dio + interceptores) | ✅ |
| 2 - Clean Arch | HU 2.1 | Clean Architecture para Auth | ✅ |
| 2 - Clean Arch | HU 2.2 | Login con validaciones + DummyJSON | ✅ |
| 2 - Clean Arch | HU 2.3 | Gestión de sesión + Route Guard | ✅ |
| 3 - Modularización | HU 3.1 | Features modulares | 🔲 |
| 3 - Modularización | HU 3.2 | Dashboard productos | 🔲 |
| 3 - Modularización | HU 3.3 | i18n | 🔲 |
| 4 - Firebase | HU 4.1 | Firebase Auth | 🔲 |
| 4 - Firebase | HU 4.2 | Historial Firestore | 🔲 |
| 4 - Firebase | HU 4.3 | Push Notifications | 🔲 |
| 5 - Python | HU 5.1 | Servicio validación | 🔲 |
| 6 - Node.js | HU 6.1 | API cuentas | 🔲 |

---

## Videos de Entrega

| Módulo | Link |
|---|---|
| Módulo 1 — Fundamentos | https://photos.app.goo.gl/4D9CC4VGDdtAGiwv5 |

---

## Autor

Walter Fuentes – Curso Flutter Avanzado, 2026

## Licencia

Proyecto académico con fines educativos y profesionales.
