# Decisiones técnicas — Módulo 3

Notas cortas sobre cómo está armada la app y por qué. Aplica al feature de
`dashboard`, que es la referencia de arquitectura para el resto.

## Modularización por features (HU 3.1)

Cada funcionalidad vive en su propia carpeta bajo `lib/features/<feature>/` y
adentro se divide en 3 capas:

```
features/dashboard/
├── domain/          # reglas y contratos. No sabe de Flutter ni de JSON.
│   ├── entities/    # Account, PaymentCard, RecentTransaction, DashboardData
│   ├── repositories/# DashboardRepository (contrato abstracto)
│   └── usecases/    # GetDashboardDataUseCase
├── data/            # de dónde salen los datos
│   ├── models/      # *Model con fromJson/toJson + toDomain()
│   ├── datasources/ # remote (mock) y local (caché)
│   └── repositories/# DashboardRepositoryImpl
└── presentation/    # lo que ve y toca el usuario
    ├── states/      # DashboardState (Freezed sealed)
    ├── controllers/ # DashboardController (Notifier)
    ├── providers/   # inyección de dependencias con Riverpod
    └── screens/     # DashboardScreen
```

La regla es que las dependencias apuntan hacia adentro: la UI depende del
dominio, nunca al revés. Por eso el mock vive en `data/datasources` y no en la
pantalla. Cuando conectemos Firebase en el M4 solo se cambia el
`RemoteDataSource`; el resto (casos de uso, estado, UI) queda igual.

### ¿Por qué Clean Architecture?

- Cada capa se prueba y se cambia por separado.
- Varias personas pueden trabajar en features distintos sin pisarse.
- La lógica de negocio no queda atrapada dentro de un widget.

## ¿Por qué Freezed? (state, entities, models)

Todas las entidades, modelos y estados usan **Freezed**. La alternativa era
escribir las clases a mano con `==`, `hashCode`, `copyWith` y `fromJson/toJson`.

Comparación con hacerlo manual:

| A mano | Con Freezed |
|--------|-------------|
| Escribir `copyWith` campo por campo | generado |
| Igualdad por valor a mano (fácil de olvidar) | generada y correcta |
| Un `if/else` o `switch` que puede quedar incompleto | `when`/pattern matching **exhaustivo** |
| Clases mutables por descuido | inmutables por defecto |

El punto más importante para nosotros es el **estado**. `DashboardState` es una
`sealed class` con 4 variantes: `initial`, `loading`, `loaded`, `error`. Como es
sellada, el compilador obliga a la pantalla a manejar los 4 casos. No se puede
"olvidar" el estado de carga o el de error.

```dart
switch (state) {
  DashboardInitial() || DashboardLoading() => spinner,
  DashboardError(:final message)           => vistaError,
  DashboardLoaded(:final data)             => contenido,
}
```

## Notifier que devuelve estado, no listas (state + notifier)

Regla que seguimos: **un Notifier nunca devuelve `List<Account>` suelto**.
Devuelve siempre su clase de estado. Cada pantalla con carga de datos tiene su
propio estado.

`DashboardController extends Notifier<DashboardState>`:

1. Empieza en `loading`.
2. Llama al caso de uso (`GetDashboardDataUseCase`).
3. Traduce el `Result` del dominio a `loaded` o `error`.

Así la pantalla solo lee estado y pinta; no sabe de repositorios ni de mocks.

Para cosas que sí son un único valor (el idioma) usamos un `Notifier<Locale>`
simple, sin clase de estado. Elegir la herramienta según el caso también es una
decisión de diseño.

## Caché local (HU 3.2)

El `DashboardRepositoryImpl` primero pide datos frescos al remoto; si funciona,
los guarda en `SharedPreferences` (serializados con el `toJson` de Freezed). Si
el remoto falla, devuelve la última caché disponible para poder ver la info sin
conexión. Si no hay ni red ni caché, propaga el error y la UI muestra la vista
de error con botón de reintento.

## Internacionalización (HU 3.3)

Se usa el flujo oficial de Flutter: archivos `.arb` (`app_es.arb`, `app_en.arb`)
y `flutter gen-l10n` genera la clase `AppLocalizations`. El idioma se guarda en
`SharedPreferences` mediante `LocaleController`. Al cambiarlo desde
Configuración, `MaterialApp` reconstruye toda la app en el nuevo idioma.
