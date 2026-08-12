# Decisiones técnicas — Módulo 4 (Firebase)

Continuación de [DECISIONES_TECNICAS.md](DECISIONES_TECNICAS.md). Mismo criterio:
tres capas por feature, entidades y estados con Freezed, y el Notifier siempre
devuelve una clase de estado.

## Regla que se mantuvo al entrar Firebase

Firebase toca exactamente **tres clases** en todo el proyecto:

| SDK | Única clase que lo importa | Capa |
|---|---|---|
| `firebase_auth` | `AuthFirebaseDataSource` | Data |
| `cloud_firestore` | `TransactionFirestoreDataSource` | Data |
| `firebase_messaging` | `FcmDataSource` | Data |

Ni el dominio ni la UI saben que existe Firebase. Por eso cambiar de DummyJSON
a Firebase Auth (HU 4.1) no obligó a tocar `LoginUseCase`, `AuthState`,
`AuthController` ni `LoginScreen`: solo se sustituyó la implementación del
`AuthRemoteDataSource`, que es justamente lo que promete Clean Architecture.

## HU 4.1 — Autenticación

El contrato `AuthRepository` no cambió. Lo que cambió fue quién lo cumple:

```
LoginUseCase → AuthRepository (contrato)
                    ↑
        AuthRepositoryImpl (Data)
           ├── AuthFirebaseDataSource   → Firebase Auth
           └── AuthSecureDataSource     → almacenamiento cifrado
```

**Almacenamiento seguro.** El token se guarda con `flutter_secure_storage`, no
con `SharedPreferences`. En Android eso significa cifrado con la Keystore del
sistema; en SharedPreferences el token quedaría en un XML en texto plano dentro
del sandbox de la app, legible en un dispositivo con root. Para un token bancario
esa diferencia importa.

`SharedPreferences` se conservó, pero solo para lo que no es sensible: la caché
del dashboard y el idioma seleccionado.

**Expiración.** Firebase emite el idToken con una hora de vigencia. Se lee la
fecha real (`IdTokenResult.expirationTime`) en lugar de asumirla, y el timer del
`AuthController` programa el logout con ese valor.

## HU 4.2 — Historial paginado

**Estructura en Firestore: `users/{uid}/transactions`.**

Se eligió subcolección en vez de una colección plana con `where('userId')`.
Motivo concreto: combinar `where` sobre un campo con `orderBy` sobre otro obliga
a Firestore a pedir un **índice compuesto** creado a mano desde la consola. Con
subcolección los documentos ya vienen acotados al usuario y basta
`orderBy('date')`, que funciona sin configurar nada. Además, las reglas de
seguridad quedan más simples.

**Paginación por cursor, no por offset.** Firestore no tiene `OFFSET`: se pagina
con `startAfter`. La consulta pide `limit + 1` documentos; si vuelve uno de más,
se sabe que hay página siguiente y se descarta ese extra. Evita una segunda
consulta solo para contar.

**El cursor no filtra hacia arriba.** El cursor natural sería un
`DocumentSnapshot`, pero ese es un tipo de Firestore y meterlo en el estado de
la UI rompería el aislamiento de capas. En su lugar el dominio expone
`TransactionPage.nextCursor` como un `DateTime` (la fecha del último elemento) y
la capa Data lo convierte en `startAfter([Timestamp])`. Las fechas del seed se
generan separadas por horas para que no haya empates.

**El estado refleja lo que la pantalla necesita.** Paginar no es solo
"cargando / cargado": hay que distinguir la carga inicial (pantalla en blanco con
spinner) de la carga de la siguiente página (la lista sigue visible y aparece un
spinner al final). Por eso `TransactionsLoaded` lleva `isLoadingMore`, `hasMore`,
`cursor` y `paginationError` dentro del mismo estado:

```dart
TransactionsState =
  | initial
  | loading                       // primera página
  | empty                         // el usuario no tiene movimientos
  | loaded(items, hasMore, isLoadingMore, cursor, paginationError)
  | error(message)
```

Si falla la página 3, `paginationError` se llena pero las páginas 1 y 2 siguen en
pantalla. Con un estado plano tipo `error` se perdería lo ya cargado.

## HU 4.3 — Notificaciones push

**El problema del primer plano.** Android muestra la notificación solo cuando la
app está en segundo plano o cerrada. Con la app abierta, FCM entrega el mensaje
pero no lo pinta. Por eso `FcmDataSource` escucha `onMessage` y dispara una
notificación local con `flutter_local_notifications`. Sin eso, en el video no se
vería nada al enviar la push con la app en pantalla.

**Handler de segundo plano.** `firebaseMessagingBackgroundHandler` es una función
de nivel superior con `@pragma('vm:entry-point')` porque Flutter la ejecuta en un
isolate separado, sin acceso al árbol de widgets ni a los providers.

**Estado.** `NotificationsState` distingue `permissionDenied` como variante
propia en lugar de tratarlo como un error genérico: es un caso esperado con su
propia pantalla y su propia acción ("volver a intentar"), no una falla.

## Reglas de seguridad de Firestore

Las de producción para esta estructura:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;

      match /transactions/{txId} {
        allow read, write: if request.auth != null
                           && request.auth.uid == userId;
      }
    }
  }
}
```

Cada usuario solo alcanza su propio documento y su propia subcolección, y solo
autenticado. Ojo: las reglas **no se heredan** hacia las subcolecciones en
Firestore, por eso el `match` interno se declara aparte y no basta con el del
documento padre.

> Durante el desarrollo basta el **modo de prueba** que ofrece la consola al
> crear la base (permite todo por 30 días). Estas reglas son las que deberían
> quedar antes de exponer la app.
