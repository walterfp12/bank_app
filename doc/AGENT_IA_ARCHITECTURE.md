# 🤖 BAM AI Agent — Arquitectura del Motor de Inteligencia Artificial

## Documento Técnico Detallado
**Proyecto:** BAM Wallet & Transfers  
**Autor:** Walter Fuentes  
**Última actualización:** 20 de febrero de 2026  

---

## Índice

1. [¿Qué es el IntentResolver?](#1-qué-es-el-intentresolver)
2. [Flujo completo paso a paso](#2-flujo-completo-paso-a-paso)
3. [Cómo funciona ahora (Pattern Matching Local)](#3-cómo-funciona-ahora-pattern-matching-local)
4. [Opción A: Integración con OpenAI / Gemini / Claude](#4-opción-a-integración-con-openai--gemini--claude)
5. [Opción B: Maximizar el pattern matching local](#5-opción-b-maximizar-el-pattern-matching-local)
6. [Seguridad bancaria — Las 10 reglas de oro](#6-seguridad-bancaria--las-10-reglas-de-oro)
7. [Comparativa: Local vs LLM](#7-comparativa-local-vs-llm)
8. [Pasos para implementar cada opción](#8-pasos-para-implementar-cada-opción)
9. [Glosario](#9-glosario)

---

## 1. ¿Qué es el IntentResolver?

El `IntentResolver` es el **cerebro clasificador** del agente IA. Su única responsabilidad es:

```
ENTRADA: Texto libre del usuario (lenguaje natural)
SALIDA:  Una acción estructurada (objeto Dart tipado)
```

### Ejemplo concreto:

| Lo que escribe el usuario | Lo que devuelve el IntentResolver |
|--------------------------|----------------------------------|
| "cuánto tengo en total" | `CheckTotalBalanceAction()` |
| "transferir Q500 a María López" | `InitiateTransferAction(amount: 500, toRecipient: 'María López')` |
| "qué le pagué a Netflix este mes" | `SearchTransactionsAction(query: 'netflix', fromDate: 2026-01-20)` |
| "bloquear mi tarjeta" | `BlockCardAction(cardId: 'card_001')` |
| "hola" | `GreetingAction()` |

### ¿Por qué es importante?

Porque **separa la comprensión del lenguaje** de la **ejecución de acciones**. Esto significa que:

1. Puedes cambiar CÓMO se entiende al usuario (local vs IA) sin tocar nada más
2. Las acciones y respuestas están controladas por TI, no por la IA
3. Los datos bancarios NUNCA pasan por el clasificador

---

## 2. Flujo completo paso a paso

```
┌─────────────────────────────────────────────────────────────────────┐
│  PASO 1: Usuario escribe                                            │
│  "quiero ver los pagos de netflix del último mes"                   │
└──────────────────────────────┬──────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  PASO 2: AgentService recibe el texto                               │
│  → Crea un AgentMessage del usuario                                 │
│  → Lo guarda en el historial                                        │
│  → Muestra indicador "escribiendo..."                               │
│  → Llama a IntentResolver.resolve(texto)                            │
│                                                                     │
│  Archivo: lib/features/agent/services/agent_service.dart            │
└──────────────────────────────┬──────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  PASO 3: IntentResolver.resolve() procesa el texto                  │
│                                                                     │
│  AHORA (local):                                                     │
│  → Convierte a minúsculas                                           │
│  → Recorre listas de patrones en orden de prioridad                 │
│  → "pagos de" coincide con _transactionSearchPatterns               │
│  → Entra a _parseTransactionSearch()                                │
│  → Detecta "netflix" en la lista de servicios                       │
│  → Detecta "último mes" en los patrones de fecha                    │
│                                                                     │
│  CON LLM (futuro):                                                  │
│  → Envía SOLO el texto a tu backend                                 │
│  → Tu backend llama a OpenAI con un System Prompt                   │
│  → OpenAI devuelve JSON: {action: "search_transactions", ...}       │
│  → Se mapea el JSON a la clase Dart correspondiente                 │
│                                                                     │
│  RESULTADO: SearchTransactionsAction(                               │
│    query: "netflix",                                                │
│    fromDate: 2026-01-20,                                            │
│    toDate: 2026-02-20,                                              │
│  )                                                                  │
│                                                                     │
│  Archivo: lib/features/agent/services/intent_resolver.dart          │
└──────────────────────────────┬──────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  PASO 4: ActionExecutor.execute() ejecuta la acción                 │
│                                                                     │
│  → Recibe SearchTransactionsAction                                  │
│  → Accede a MockDataService.transactions (datos locales/API)        │
│  → Filtra: título contiene "netflix"                                │
│  → Filtra: fecha >= 2026-01-20                                      │
│  → Encuentra: "Pago Netflix - Q119.00 - Suscripción mensual"       │
│  → Calcula total: Q119.00                                           │
│  → Genera texto formateado con emojis                               │
│  → Genera RichContent (tarjeta visual de transacciones)             │
│  → Genera sugerencias rápidas                                       │
│                                                                     │
│  ⚠️ AQUÍ es donde se acceden los datos bancarios reales            │
│  ⚠️ Los datos NUNCA salen de tu app/servidor                       │
│                                                                     │
│  Archivo: lib/features/agent/services/action_executor.dart          │
└──────────────────────────────┬──────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  PASO 5: La UI muestra la respuesta                                 │
│                                                                     │
│  → Burbuja de chat con texto:                                       │
│    "🔍 Encontré 1 transacción:                                     │
│     🔴 Pago Netflix -Q119.00 · 16/02/2026                         │
│     Suscripción mensual                                             │
│     💵 Total: Q119.00"                                              │
│                                                                     │
│  → Tarjeta visual (RichCard) con la transacción                     │
│  → Sugerencias: "📊 Todos" | "🔍 Otro servicio"                   │
│                                                                     │
│  Archivo: lib/features/agent/screens/agent_chat_screen.dart         │
└─────────────────────────────────────────────────────────────────────┘
```

### Diagrama de separación de responsabilidades:

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│  IntentResolver   │     │  ActionExecutor   │     │  Chat UI         │
│                  │     │                  │     │                  │
│  "¿Qué quiere   │────▶│  "Ejecuto la     │────▶│  "Muestro los   │
│   el usuario?"   │     │   acción con     │     │   resultados    │
│                  │     │   datos reales"  │     │   bonitos"      │
│  NO toca datos   │     │  SÍ toca datos   │     │  NO toca datos  │
│  bancarios       │     │  bancarios       │     │  directamente   │
└──────────────────┘     └──────────────────┘     └──────────────────┘
```

---

## 3. Cómo funciona ahora (Pattern Matching Local)

### Anatomía del código actual:

```dart
static AgentAction resolve(String input) {
  // 1. Normalizar texto
  final text = input.toLowerCase().trim();
  
  // 2. Cascada de detección por prioridad
  // (el orden importa — se evalúa de arriba a abajo)
  
  if (_matchesAny(text, _greetingPatterns)) {     // Prioridad 1: Saludos
    return const GreetingAction();
  }
  
  if (_matchesAny(text, _transferPatterns)) {      // Prioridad 3: Transferencias
    return _parseTransferIntent(text);             // ← Parseo avanzado
  }
  
  // ...más patrones...
  
  return UnknownAction(originalMessage: input);    // Último: No reconocido
}
```

### ¿Qué es `_matchesAny`?

```dart
static bool _matchesAny(String text, List<String> patterns) {
  return patterns.any((p) => text.contains(p));
}
```

Simplemente verifica si el texto contiene ALGUNA de las frases de la lista. Por ejemplo:

```dart
// Si el usuario dice "quiero ver mi saldo total por favor"
// text = "quiero ver mi saldo total por favor"

_matchesAny(text, ['saldo total', 'balance total', ...])
// → text.contains('saldo total') → TRUE ✅
```

### Orden de prioridad (por qué importa):

```
1. Saludos          ← "hola" se detecta primero
2. Ayuda            ← "ayuda" tiene prioridad alta
3. Transferencias   ← "transferir" antes de "saldo" (más específico)
4. Confirmación     ← "si", "confirmar" (contexto de transferencia)
5. Cancelar         ← "cancelar", "no quiero"
6. Saldo total      ← "saldo total" antes de solo "saldo" (más específico)
7. Saldo            ← "saldo" genérico
8. Buscar txns      ← "pagos a", "gastos en"
9. Txns recientes   ← "últimos movimientos"
10. Cuentas         ← "mis cuentas"
11. Tarjetas        ← "mis tarjetas"
12. Bloquear        ← "bloquear tarjeta"
13. Perfil          ← "mis datos"
14. Notificaciones  ← "notificaciones"
15. Push tokens     ← "push token"
16. Análisis        ← "cuánto he gastado"
17. Navegación      ← "ir a inicio"
18. No reconocido   ← Fallback final
```

### Parsers avanzados (extraen datos del texto):

#### Parser de transferencias:
```dart
Entrada: "transferir q500 a María López por alquiler"
                      ↓
Regex de monto:    q\s*(\d+...)  → 500
Regex de destino:  (?:a|para)\s+([A-Z]...)  → "María López"
Regex de concepto: (?:por concepto de|por)\s+(.+)  → "alquiler"
                      ↓
Salida: InitiateTransferAction(amount: 500, toRecipient: "María López", description: "alquiler")
```

#### Parser de búsqueda de transacciones:
```dart
Entrada: "pagos de netflix del último mes"
                      ↓
Lista de servicios: ['netflix', 'spotify', ...]  → query = "netflix"
Patrones de fecha:  "último mes"  → fromDate = hace 30 días
                      ↓
Salida: SearchTransactionsAction(query: "netflix", fromDate: 2026-01-20)
```

---

## 4. Opción A: Integración con OpenAI / Gemini / Claude

### Arquitectura de seguridad obligatoria:

```
┌─────────────┐         ┌─────────────────────┐         ┌──────────────┐
│  Flutter App │  HTTPS  │  Tu Backend Propio  │  HTTPS  │  OpenAI API  │
│  (cliente)   │────────▶│  (Firebase/Node.js)  │────────▶│  (externo)   │
│              │         │                     │         │              │
│  Envía SOLO  │         │  • Valida JWT       │         │  Recibe SOLO │
│  el texto    │         │  • Rate limiting    │         │  el texto +  │
│  del usuario │         │  • Sanitiza input   │         │  System      │
│              │         │  • Guarda API key   │         │  Prompt      │
│  NUNCA envía │         │  • Log de auditoría │         │              │
│  datos       │         │  • Fallback local   │         │  NUNCA ve    │
│  bancarios   │         │                     │         │  datos       │
│              │◀────────│  Devuelve JSON      │◀────────│  bancarios   │
│              │         │  con la acción      │         │              │
└─────────────┘         └─────────────────────┘         └──────────────┘
```

### ⚠️ REGLA DE ORO: La app NUNCA habla directamente con OpenAI

```
❌ PROHIBIDO:
Flutter → api.openai.com  (API key expuesta en el APK)

✅ CORRECTO:
Flutter → tu-backend.com/ai/intent → api.openai.com
```

### Paso a paso de cómo funcionaría:

#### PASO 1: El IntentResolver cambia de sync a async

```dart
// ANTES (local, síncrono):
static AgentAction resolve(String input) {
  final text = input.toLowerCase().trim();
  if (_matchesAny(text, _greetingPatterns)) {
    return const GreetingAction();
  }
  // ...200 líneas de ifs...
}

// DESPUÉS (con LLM, asíncrono):
static Future<AgentAction> resolve(String input) async {
  try {
    // 1. Intentar con IA primero
    return await _resolveWithLLM(input);
  } catch (e) {
    // 2. Si falla, caer al pattern matching local
    return _resolveLocal(input);
  }
}
```

#### PASO 2: Tu backend (Node.js o Firebase Functions)

```javascript
// backend/functions/intent.js (ejemplo Firebase Functions)

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

// System Prompt — el "cerebro" de tu agente
const SYSTEM_PROMPT = `
Eres un clasificador de intenciones para una app bancaria guatemalteca.
Tu ÚNICO trabajo es analizar el texto del usuario y devolver un JSON.

REGLAS ESTRICTAS:
- SOLO devuelve JSON válido, nada más
- NUNCA inventes datos bancarios (saldos, cuentas, etc.)
- NUNCA pidas información sensible al usuario
- Si no entiendes, devuelve {"action": "unknown"}

ACCIONES DISPONIBLES:

1. Saludos:
   {"action": "greeting"}

2. Ayuda:
   {"action": "help"}

3. Consultar saldo total:
   {"action": "check_total_balance"}

4. Consultar saldo de cuenta:
   {"action": "check_balance", "params": {"accountId": null}}

5. Listar cuentas:
   {"action": "list_accounts"}

6. Buscar transacciones:
   {"action": "search_transactions", "params": {
     "query": "nombre del comercio o null",
     "category": "categoría o null",
     "fromDate": "YYYY-MM-DD o null",
     "toDate": "YYYY-MM-DD o null"
   }}

7. Transacciones recientes:
   {"action": "recent_transactions", "params": {"limit": 5}}

8. Iniciar transferencia:
   {"action": "initiate_transfer", "params": {
     "amount": 500.00,
     "toRecipient": "nombre del destinatario",
     "description": "concepto o null"
   }}

9. Confirmar transferencia:
   {"action": "confirm_transfer"}

10. Cancelar:
    {"action": "cancel"}

11. Listar tarjetas:
    {"action": "list_cards"}

12. Bloquear tarjeta:
    {"action": "block_card", "params": {"cardId": null}}

13. Ver perfil:
    {"action": "view_profile"}

14. Configurar notificaciones:
    {"action": "configure_notifications"}

15. Configurar push token:
    {"action": "configure_push_token"}

16. Análisis de gastos:
    {"action": "spending_analysis", "params": {
      "fromDate": "YYYY-MM-DD o null",
      "toDate": "YYYY-MM-DD o null"
    }}

17. Gastos por categoría:
    {"action": "spending_by_category", "params": {
      "category": "nombre de categoría",
      "fromDate": "YYYY-MM-DD o null",
      "toDate": "YYYY-MM-DD o null"
    }}

18. Navegar:
    {"action": "navigate", "params": {"route": "/dashboard|/transfers|/history|/settings"}}

19. No reconocido:
    {"action": "unknown", "params": {"originalMessage": "texto original"}}

EJEMPLOS:
Usuario: "cuánto tengo en total" → {"action": "check_total_balance"}
Usuario: "transferir Q500 a María" → {"action": "initiate_transfer", "params": {"amount": 500, "toRecipient": "María"}}
Usuario: "pagos de netflix este mes" → {"action": "search_transactions", "params": {"query": "netflix", "fromDate": "2026-02-01", "toDate": "2026-02-20"}}

La fecha actual es: ${new Date().toISOString().split('T')[0]}
`;

exports.resolveIntent = async (req, res) => {
  // 1. Validar autenticación
  const token = req.headers.authorization?.split('Bearer ')[1];
  if (!token) return res.status(401).json({ error: 'No autorizado' });

  // 2. Validar y verificar JWT
  try {
    const decoded = await admin.auth().verifyIdToken(token);
    const userId = decoded.uid;
  } catch (e) {
    return res.status(401).json({ error: 'Token inválido' });
  }

  // 3. Rate limiting (máximo 30 requests por minuto por usuario)
  const rateLimitKey = `ratelimit:${userId}`;
  const requests = await redis.incr(rateLimitKey);
  if (requests === 1) await redis.expire(rateLimitKey, 60);
  if (requests > 30) return res.status(429).json({ error: 'Demasiadas solicitudes' });

  // 4. Sanitizar input
  const userText = req.body.text?.substring(0, 500)?.trim();
  if (!userText) return res.status(400).json({ error: 'Texto vacío' });

  // 5. Llamar a OpenAI
  try {
    const completion = await openai.chat.completions.create({
      model: 'gpt-4o-mini',         // Rápido y barato para clasificación
      temperature: 0,                // Determinístico (siempre la misma respuesta)
      max_tokens: 200,               // Limitar la respuesta
      response_format: { type: 'json_object' },  // Forzar JSON
      messages: [
        { role: 'system', content: SYSTEM_PROMPT },
        { role: 'user', content: userText },
      ],
    });

    const result = JSON.parse(completion.choices[0].message.content);

    // 6. Log de auditoría (obligatorio en banca)
    await db.collection('ai_audit_log').add({
      userId,
      input: userText,
      output: result,
      model: 'gpt-4o-mini',
      tokens: completion.usage.total_tokens,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    // 7. Devolver resultado
    return res.json(result);

  } catch (e) {
    // 8. Si OpenAI falla, devolver fallback
    console.error('OpenAI error:', e);
    return res.json({ action: 'unknown', params: { originalMessage: userText } });
  }
};
```

#### PASO 3: El IntentResolver en Flutter llama al backend

```dart
// intent_resolver.dart — versión con LLM

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/agent_action.dart';

class IntentResolver {
  IntentResolver._();

  static const _backendUrl = 'https://tu-backend.com/ai/intent';

  /// Resuelve con IA (intenta LLM, fallback a local)
  static Future<AgentAction> resolve(String input) async {
    try {
      return await _resolveWithLLM(input);
    } catch (e) {
      // Fallback silencioso al pattern matching local
      return _resolveLocal(input);
    }
  }

  /// Llamada al backend → OpenAI
  static Future<AgentAction> _resolveWithLLM(String input) async {
    final response = await http.post(
      Uri.parse(_backendUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userJwtToken',  // Token del usuario logueado
      },
      body: jsonEncode({
        'text': input,  // ⚠️ SOLO el texto, NADA de datos bancarios
      }),
    ).timeout(const Duration(seconds: 5));  // Timeout de 5 segundos

    if (response.statusCode != 200) {
      throw Exception('Backend error: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return _mapJsonToAction(json);
  }

  /// Mapea el JSON del backend a una AgentAction tipada
  static AgentAction _mapJsonToAction(Map<String, dynamic> json) {
    final action = json['action'] as String;
    final params = json['params'] as Map<String, dynamic>? ?? {};

    return switch (action) {
      'greeting' => const GreetingAction(),
      'help' => const HelpAction(),
      'check_total_balance' => const CheckTotalBalanceAction(),
      'check_balance' => CheckBalanceAction(accountId: params['accountId']),
      'list_accounts' => const ListAccountsAction(),
      'search_transactions' => SearchTransactionsAction(
        query: params['query'],
        category: params['category'],
        fromDate: params['fromDate'] != null ? DateTime.parse(params['fromDate']) : null,
        toDate: params['toDate'] != null ? DateTime.parse(params['toDate']) : null,
      ),
      'recent_transactions' => GetRecentTransactionsAction(limit: params['limit'] ?? 5),
      'initiate_transfer' => InitiateTransferAction(
        amount: (params['amount'] as num?)?.toDouble(),
        toRecipient: params['toRecipient'],
        description: params['description'],
      ),
      'confirm_transfer' => const ConfirmTransferAction(transferId: 'pending'),
      'cancel' => const CancelTransferAction(),
      'list_cards' => const ListCardsAction(),
      'block_card' => BlockCardAction(cardId: params['cardId'] ?? 'card_001'),
      'view_profile' => const ViewProfileAction(),
      'configure_notifications' => const ConfigureNotificationsAction(),
      'configure_push_token' => const ConfigurePushTokenAction(),
      'spending_analysis' => SpendingAnalysisAction(
        fromDate: params['fromDate'] != null ? DateTime.parse(params['fromDate']) : null,
        toDate: params['toDate'] != null ? DateTime.parse(params['toDate']) : null,
      ),
      'spending_by_category' => SpendingByCategoryAction(
        category: params['category'] ?? '',
        fromDate: params['fromDate'] != null ? DateTime.parse(params['fromDate']) : null,
        toDate: params['toDate'] != null ? DateTime.parse(params['toDate']) : null,
      ),
      'navigate' => NavigateAction(route: params['route'] ?? '/dashboard'),
      _ => UnknownAction(originalMessage: params['originalMessage'] ?? input),
    };
  }

  /// Fallback: pattern matching local (el código actual)
  static AgentAction _resolveLocal(String input) {
    final text = input.toLowerCase().trim();
    // ... todo el código actual de patterns ...
  }
}
```

### Costo estimado con OpenAI (gpt-4o-mini):

| Uso | Tokens/request | Costo/request | 1,000 users × 20 msgs/día |
|-----|---------------|---------------|---------------------------|
| Input (system + user) | ~800 tokens | ~$0.00012 | $2.40/día |
| Output (JSON) | ~50 tokens | ~$0.00003 | $0.60/día |
| **Total** | **~850** | **~$0.00015** | **~$3.00/día ≈ $90/mes** |

---

## 5. Opción B: Maximizar el pattern matching local

Si prefieres NO usar una IA externa (por costos, privacidad, o regulación), puedes hacer el sistema local mucho más inteligente:

### Técnica 1: Normalización avanzada del texto

```dart
static String _normalize(String text) {
  var normalized = text.toLowerCase().trim();
  
  // Quitar tildes
  const accents = 'áéíóúñü';
  const plain   = 'aeiounU';
  for (int i = 0; i < accents.length; i++) {
    normalized = normalized.replaceAll(accents[i], plain[i]);
  }
  
  // Quitar signos de puntuación
  normalized = normalized.replaceAll(RegExp(r'[¿?¡!.,;:]'), '');
  
  // Quitar palabras vacías (stop words)
  final stopWords = ['el', 'la', 'los', 'las', 'un', 'una', 'de', 
                     'del', 'que', 'en', 'por', 'con', 'me', 'mi',
                     'yo', 'se', 'le', 'lo', 'es', 'y', 'o', 'pero'];
  final words = normalized.split(' ')
    .where((w) => !stopWords.contains(w) && w.isNotEmpty)
    .toList();
  
  return words.join(' ');
}
```

**Resultado:** "¿Cuánto le pagué a Netflix?" → "cuanto pague netflix"

### Técnica 2: Similitud difusa (fuzzy matching)

```dart
/// Distancia de Levenshtein — ¿qué tan parecidas son dos palabras?
static int _levenshtein(String a, String b) {
  final matrix = List.generate(a.length + 1, 
    (i) => List.generate(b.length + 1, (j) => 0));
  
  for (int i = 0; i <= a.length; i++) matrix[i][0] = i;
  for (int j = 0; j <= b.length; j++) matrix[0][j] = j;
  
  for (int i = 1; i <= a.length; i++) {
    for (int j = 1; j <= b.length; j++) {
      final cost = a[i-1] == b[j-1] ? 0 : 1;
      matrix[i][j] = [
        matrix[i-1][j] + 1,      // eliminación
        matrix[i][j-1] + 1,      // inserción
        matrix[i-1][j-1] + cost,  // sustitución
      ].reduce((a, b) => a < b ? a : b);
    }
  }
  return matrix[a.length][b.length];
}

/// ¿La palabra es "suficientemente parecida"?
static bool _fuzzyMatch(String word, String target, {int threshold = 2}) {
  return _levenshtein(word, target) <= threshold;
}
```

**Resultado:** "trnasferir" (typo) → detecta que es parecido a "transferir" ✅

### Técnica 3: Sinónimos y jerga local (Guatemala)

```dart
static const _synonyms = {
  // Transferencias
  'transferir': ['pasar', 'enviar', 'mandar', 'depositar', 'girar'],
  'plata': ['dinero', 'pisto', 'lana', 'feria', 'centavos', 'billete'],
  'saldo': ['balance', 'disponible', 'fondos', 'lana', 'pisto'],
  
  // Jerga guatemalteca
  'pisto': ['dinero'],
  'mara': ['amigo', 'persona'],
  'cabal': ['exacto', 'correcto', 'sí'],
  'simón': ['sí', 'confirmar'],
  'nel': ['no', 'cancelar'],
  'va': ['ok', 'sí', 'confirmar'],
  'aguas': ['cuidado', 'alerta'],
  
  // Abreviaciones comunes
  'transf': ['transferencia'],
  'config': ['configuración'],
  'noti': ['notificaciones'],
  'info': ['información'],
};
```

### Técnica 4: Scoring por relevancia

```dart
/// En lugar de un simple contains(), calcular un score
static (AgentAction, double) _scoreIntent(String text) {
  final scores = <AgentAction, double>{};
  
  // Calcular score para cada posible intención
  for (final pattern in _transferPatterns) {
    if (text.contains(pattern)) {
      scores[_parseTransferIntent(text)] = 
        (scores[_parseTransferIntent(text)] ?? 0) + 1.0;
    }
  }
  
  // Bonus por palabras clave fuertes
  if (text.contains('q') && RegExp(r'\d+').hasMatch(text)) {
    scores[_parseTransferIntent(text)] = 
      (scores[_parseTransferIntent(text)] ?? 0) + 0.5;  // Tiene monto
  }
  
  // Retornar la acción con mayor score
  final best = scores.entries.reduce((a, b) => a.value > b.value ? a : b);
  return (best.key, best.value);
}
```

### Técnica 5: Agregar MUCHOS más patrones

```dart
// Lista expandida — cubrir todas las variantes posibles
static const _transferPatterns = [
  // Formales
  'transferir', 'transferencia', 'enviar dinero', 'enviar fondos',
  'realizar transferencia', 'hacer transferencia', 'nueva transferencia',
  
  // Informales
  'pasar plata', 'pasar pisto', 'mandar plata', 'mandar pisto',
  'enviar plata', 'enviar pisto', 'depositar',
  
  // Imperativo
  'transfiere', 'envía', 'manda', 'pasa', 'deposita',
  
  // Con contexto
  'quiero transferir', 'necesito transferir', 'puedes transferir',
  'hazme una transferencia', 'haz una transferencia',
  
  // Coloquial guatemalteco
  'pásale pisto', 'mándale pisto', 'enviale lana',
  
  // Con preposición
  'pagar a', 'pagarle a', 'hacer pago a',
];
```

---

## 6. Seguridad bancaria — Las 10 reglas de oro

### Regla 1: NUNCA enviar datos bancarios al LLM

```
❌ PROHIBIDO enviar a OpenAI:
"El usuario Walter Fuentes (DPI: 1234567890101) con 
 cuenta 0012345678901 y saldo Q45,750.50 quiere..."

✅ CORRECTO enviar a OpenAI:
"transferir Q500 a María López"

El LLM solo CLASIFICA la intención.
El ActionExecutor accede a los datos LOCALMENTE.
```

### Regla 2: API key NUNCA en el cliente

```
❌ PROHIBIDO:
// En tu código Flutter
const apiKey = 'sk-proj-abc123...';  // Se puede extraer del APK

✅ CORRECTO:
// La API key vive SOLO en el backend (variable de entorno)
// Flutter solo tiene el URL de TU backend
```

### Regla 3: Autenticación en cada request

```dart
// Cada llamada al backend DEBE llevar el JWT del usuario
headers: {
  'Authorization': 'Bearer $firebaseIdToken',
  'X-Device-Id': deviceId,  // Identificar dispositivo
}
```

### Regla 4: Rate limiting estricto

```
Máximo 30 mensajes al agente por minuto por usuario.
Máximo 500 mensajes por día por usuario.
Si se excede → bloquear temporalmente + alerta de seguridad.
```

### Regla 5: Sanitización de input

```dart
// ANTES de enviar al LLM
String sanitize(String input) {
  // Limitar longitud
  if (input.length > 500) input = input.substring(0, 500);
  
  // Remover caracteres de control
  input = input.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
  
  // Detectar prompt injection
  final dangerousPatterns = [
    'ignore previous', 'ignore above', 'system prompt',
    'new instructions', 'forget everything', 'act as',
    'DAN', 'jailbreak', 'pretend you are',
  ];
  for (final p in dangerousPatterns) {
    if (input.toLowerCase().contains(p)) {
      return '[BLOCKED]';  // No enviar al LLM
    }
  }
  
  return input;
}
```

### Regla 6: Doble confirmación para operaciones sensibles

```
Transferencias: SIEMPRE requieren confirmación explícita
Bloqueo de tarjeta: SIEMPRE requiere confirmación
Cambio de datos: SIEMPRE requiere confirmación

El agente NUNCA ejecuta una acción destructiva sin confirmación.
```

### Regla 7: Respuestas controladas (no texto libre del LLM)

```
❌ PROHIBIDO:
Que el LLM genere la respuesta al usuario directamente.
(Podría "alucinar" un saldo incorrecto o dar info falsa)

✅ CORRECTO:
El LLM solo dice: {action: "check_balance"}
Tu código genera: "Tu saldo es Q45,750.50" (dato real de tu DB)
```

### Regla 8: Audit logging (obligatorio en regulación financiera)

```javascript
// Cada interacción con el agente se registra
{
  userId: "usr_001",
  timestamp: "2026-02-20T14:30:00Z",
  input: "transferir Q500 a María",
  resolvedAction: "initiate_transfer",
  llmModel: "gpt-4o-mini",
  tokensUsed: 850,
  responseTime: 420,  // ms
  wasExecuted: true,
  ipAddress: "xxx.xxx.xxx.xxx",
  deviceId: "iphone_15_pro_xxx",
}
```

### Regla 9: Timeout y fallback

```dart
// Si OpenAI tarda más de 5 segundos → usar local
.timeout(const Duration(seconds: 5))

// Si el backend está caído → usar local
catch (e) {
  return _resolveLocal(input);  // Siempre funciona
}
```

### Regla 10: Cumplimiento regulatorio

```
Guatemala (SIB - Superintendencia de Bancos):
├── Los datos de clientes NO pueden salir del país sin autorización
│   → Considerar Azure OpenAI con región en América
│   → O usar modelo on-premise (Llama 3, Mistral)
│
├── Todo acceso a datos debe quedar registrado (auditoría)
│   → Log de cada interacción del agente
│
├── Política de privacidad debe mencionar uso de IA
│   → Agregar términos de servicio
│
└── El usuario debe poder optar por no usar el agente IA
    → Modo tradicional siempre disponible
```

---

## 7. Comparativa: Local vs LLM

| Criterio | Pattern Matching Local | LLM (OpenAI/Gemini) |
|----------|----------------------|---------------------|
| **Costo** | $0 | ~$90/mes (1K usuarios) |
| **Latencia** | 0ms | 200-800ms |
| **Precisión** | ~70% (frases comunes) | ~95% (entiende variaciones) |
| **Offline** | ✅ Funciona siempre | ❌ Necesita internet |
| **Privacidad** | ✅ Datos en el dispositivo | ⚠️ Texto sale al servidor |
| **Mantenimiento** | Alto (agregar patrones) | Bajo (el LLM se adapta) |
| **Idiomas** | Solo español | Cualquier idioma |
| **Typos** | ❌ No los tolera | ✅ Los entiende |
| **Jerga** | Manual (agregar) | ✅ La entiende |
| **Contexto** | ❌ Cada mensaje es aislado | ✅ Puede mantener contexto |
| **Regulación** | ✅ Sin riesgo | ⚠️ Requiere evaluación legal |

### Recomendación:

```
FASE 1 (Ahora):     Pattern matching local ← ESTÁS AQUÍ
FASE 2 (Siguiente):  Híbrido (local + LLM para fallback)
FASE 3 (Producción):  LLM con backend propio + auditoría completa
```

---

## 8. Pasos para implementar cada opción

### Opción A: Mejorar el pattern matching local

```
Paso 1: Implementar normalización avanzada (quitar tildes, stop words)
Paso 2: Agregar sinónimos y jerga guatemalteca
Paso 3: Implementar fuzzy matching (Levenshtein)
Paso 4: Expandir patrones (cubrir más frases por cada intención)
Paso 5: Implementar scoring (elegir la mejor coincidencia)
Paso 6: Testing exhaustivo con frases reales de usuarios
Paso 7: Agregar analytics para detectar frases no reconocidas
```

### Opción B: Integrar OpenAI

```
Paso 1:  Crear backend (Firebase Functions o Node.js en Cloud Run)
Paso 2:  Obtener API key de OpenAI (platform.openai.com)
Paso 3:  Implementar endpoint /ai/intent en el backend
Paso 4:  Escribir y probar el System Prompt
Paso 5:  Agregar autenticación JWT al endpoint
Paso 6:  Agregar rate limiting
Paso 7:  Agregar sanitización de input (anti prompt injection)
Paso 8:  Agregar audit logging
Paso 9:  Cambiar IntentResolver a async con fallback local
Paso 10: Testing de integración
Paso 11: Evaluación legal/regulatoria (SIB Guatemala)
Paso 12: Deploy a producción con monitoreo
```

### Opción C: Modelo on-premise (máxima privacidad)

```
Paso 1: Elegir modelo (Llama 3 8B, Mistral 7B, Gemma 2B)
Paso 2: Deploy en tu propio servidor (Cloud Run GPU o EC2 con GPU)
Paso 3: El flujo es idéntico a Opción B pero todo queda en TU infra
Paso 4: Costo: ~$200-500/mes por GPU, pero CERO riesgo de filtración
```

---

## 9. Glosario

| Término | Significado |
|---------|-------------|
| **IntentResolver** | El módulo que convierte texto natural en acciones estructuradas |
| **ActionExecutor** | El módulo que ejecuta las acciones y accede a datos reales |
| **AgentAction** | Clase sellada (sealed) que representa una intención del usuario |
| **Pattern Matching** | Técnica de buscar patrones de texto predefinidos |
| **LLM** | Large Language Model (modelo de lenguaje grande: GPT, Gemini, Claude) |
| **System Prompt** | Instrucciones que le das al LLM para definir su comportamiento |
| **JWT** | JSON Web Token — token de autenticación del usuario |
| **Rate Limiting** | Limitar la cantidad de requests por usuario por tiempo |
| **Prompt Injection** | Ataque donde el usuario intenta manipular las instrucciones del LLM |
| **Fallback** | Plan B cuando el sistema principal falla |
| **Audit Log** | Registro de todas las acciones para cumplimiento regulatorio |
| **SIB** | Superintendencia de Bancos de Guatemala (regulador financiero) |
| **On-premise** | Modelo de IA corriendo en tus propios servidores |
| **Fuzzy Matching** | Encontrar coincidencias "aproximadas" (tolera errores de escritura) |
| **Sealed Class** | Clase de Dart que define un conjunto cerrado de subtipos (como un enum con datos) |
| **NLP** | Natural Language Processing (procesamiento de lenguaje natural) |

---

## Archivos relacionados en el proyecto

```
lib/features/agent/
├── models/
│   ├── agent_message.dart      ← Modelo de mensaje (texto, rich, sugerencias)
│   └── agent_action.dart       ← 20+ acciones tipadas (sealed class)
├── services/
│   ├── intent_resolver.dart    ← 🧠 ESTE ARCHIVO (el cerebro)
│   ├── action_executor.dart    ← Ejecuta acciones contra datos reales
│   └── agent_service.dart      ← Orquestador principal
├── widgets/
│   ├── agent_fab.dart          ← Botón flotante con glow
│   ├── agent_chat_bubble.dart  ← Burbujas de chat
│   ├── agent_typing_indicator.dart ← Animación "escribiendo..."
│   └── agent_rich_card.dart    ← 7 tipos de tarjetas visuales
└── screens/
    └── agent_chat_screen.dart  ← Pantalla completa del chat
```
