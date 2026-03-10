# BAM Wallet & Transfers

**Módulo Bancario Escalable** – Proyecto transversal del curso Flutter Avanzado.

---

## Descripción

Aplicación bancaria móvil que simula un módulo real de una app financiera de alto tráfico.
Incluye autenticación, visualización de productos/saldos, transferencias, historial de transacciones y configuración.

## Tecnologías

| Tecnología | Versión | Uso |
|---|---|---|
| Flutter | 3.41.1 | Framework UI multiplataforma |
| Dart | 3.11.0 | Lenguaje de programación |
| go_router | 14.x | Navegación declarativa |
| provider | 6.x | Manejo de estado |
| http | 1.x | Cliente HTTP |
| google_fonts | 6.x | Tipografía |
| intl | 0.20.x | Formateo i18n |
| shared_preferences | 2.x | Almacenamiento local |

## Plataformas Soportadas

- Android
- iOS
- Web

## Estructura del Proyecto

```
lib/
├── core/                   # Código compartido
│   ├── constants/          # Colores, strings, dimensiones
│   ├── errors/             # Modelo de errores centralizado
│   ├── theme/              # Tema Material 3
│   ├── utils/              # Utilidades (formato, validaciones)
│   └── widgets/            # Widgets reutilizables
├── features/               # Módulos por funcionalidad
│   ├── auth/               # Autenticación (HU 2.x)
│   ├── home/               # Dashboard (HU 3.2)
│   ├── accounts/           # Cuentas bancarias
│   ├── transactions/       # Transferencias e historial (HU 4.2)
│   ├── cards/              # Tarjetas
│   └── profile/            # Configuración
├── routes/                 # Navegación (go_router)
├── services/               # Servicios (HTTP, datos mock)
└── main.dart               # Punto de entrada
```

## Configuración y Ejecución

### Prerrequisitos

- Flutter SDK >= 3.41.0
- Dart >= 3.11.0
- Android Studio / Xcode (para móvil)
- Chrome (para web)

### Instalación

```bash
# 1. Clonar el repositorio
git clone <url-del-repo>
cd bank_app

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar la app
flutter run                 # Dispositivo conectado
flutter run -d chrome       # Web
flutter run -d ios          # iOS Simulator
flutter run -d android      # Android Emulator
```

### Verificar el proyecto

```bash
flutter analyze             # Análisis estático
flutter test                # Ejecutar pruebas
flutter doctor              # Verificar entorno
```

## Backlog del Proyecto

| Módulo | HU | Estado |
|---|---|---|
| 1 - Fundamentos | HU 1.1 Config profesional | ✅ |
| 1 - Fundamentos | HU 1.2 Navegación base | ✅ |
| 1 - Fundamentos | HU 1.3 Cliente HTTP | ✅ |
| 2 - Clean Arch | HU 2.1 Clean Arch Auth | 🔲 |
| 2 - Clean Arch | HU 2.2 Login validaciones | 🔲 |
| 2 - Clean Arch | HU 2.3 Gestión sesión | 🔲 |
| 3 - Modularización | HU 3.1 Features modulares | 🔲 |
| 3 - Modularización | HU 3.2 Dashboard productos | 🔲 |
| 3 - Modularización | HU 3.3 i18n | 🔲 |
| 4 - Firebase | HU 4.1 Firebase Auth | 🔲 |
| 4 - Firebase | HU 4.2 Historial Firestore | 🔲 |
| 4 - Firebase | HU 4.3 Push Notifications | 🔲 |
| 5 - Python | HU 5.1 Servicio validación | 🔲 |
| 6 - Node.js | HU 6.1 API cuentas | 🔲 |

## Arquitectura

El proyecto sigue **Clean Architecture** con modularización por features:

```
Presentación (UI)  →  Dominio (Casos de uso)  →  Datos (Repositorios/API)
     Screens              Use Cases                 Repositories
     Widgets              Entities                  Data Sources
     Providers            Repository Interfaces     Models
```

## Link video primera entrega funcionalidad 

https://photos.app.goo.gl/4D9CC4VGDdtAGiwv5


## Autor

Walter Fuentes – Curso Flutter Avanzado, 2026

## Licencia

Proyecto académico con fines educativos y profesionales.
