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
│   ├── i18n/               # LocaleController (idioma persistido)
│   ├── providers/          # infrastructure_providers (SharedPrefs, HttpClient)
│   ├── theme/              # Tema Material 3
│   └── utils/              # Validators, formatters
├── features/
│   ├── auth/               # Autenticación — Clean Architecture completa
│   ├── dashboard/          # Dashboard productos/saldos (Domain/Data/Presentation)
│   ├── agent/              # Pantalla Agente IA (AgentChatScreen)
│   ├── transactions/       # Transferencias e historial
│   └── profile/            # Configuración / Settings
├── l10n/                   # app_es.arb, app_en.arb + AppLocalizations generado
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

## Módulo 3 — Dashboard, estados e i18n

El feature `dashboard` es la referencia de arquitectura: 3 capas
(Domain / Data / Presentation), todo con Freezed.

- **Estado propio, no listas.** `DashboardController` es un `Notifier<DashboardState>`
  y `DashboardState` es una `sealed class` de Freezed con 4 variantes:
  `initial`, `loading`, `loaded` y `error`. La pantalla hace pattern matching
  exhaustivo, así que carga y error siempre se manejan.
- **Mock en su capa.** Los datos de ejemplo viven en `DashboardRemoteDataSourceMock`
  (capa Data), no en la UI. Cambiar a Firebase en el M4 es reemplazar solo esa clase.
- **Caché local.** El repositorio guarda el último dashboard en `SharedPreferences`
  y lo usa como respaldo sin conexión.
- **Distintos tipos de tarjeta** (débito / crédito / prepago) en un carrusel.
- **i18n** con archivos `.arb` + `flutter gen-l10n`. El idioma se cambia desde
  Configuración y se guarda con `LocaleController`.

Detalle y justificación técnica en [`docs/DECISIONES_TECNICAS.md`](docs/DECISIONES_TECNICAS.md).

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
| 3 - Modularización | HU 3.1 | Features modulares + doc técnico | ✅ |
| 3 - Modularización | HU 3.2 | Dashboard productos (estados + caché) | ✅ |
| 3 - Modularización | HU 3.3 | i18n español/inglés + selector | ✅ |
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
| Módulo 2 — Autenticación | https://photos.app.goo.gl/YimSyuPhREPBbvnt7 |

---

## Autor

Walter Fuentes – Curso Flutter Avanzado, 2026

## Licencia

Proyecto académico con fines educativos y profesionales.
