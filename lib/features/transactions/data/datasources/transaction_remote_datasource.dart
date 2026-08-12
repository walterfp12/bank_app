import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/transaction_entity.dart';
import '../models/transaction_model.dart';

/// DataSource remoto de transacciones – capa Data (HU 4.2).
///
/// Única clase que conoce `cloud_firestore`.
///
/// **Estructura elegida:** `users/{uid}/transactions`. Al ser una subcolección,
/// las transacciones ya están acotadas al usuario y basta con `orderBy('date')`
/// para paginar. Si se usara una colección plana con `where('userId')` +
/// `orderBy('date')`, Firestore exigiría crear un índice compuesto a mano.
abstract interface class TransactionRemoteDataSource {
  Future<({List<TransactionModel> items, bool hasMore})> fetchPage({
    required String userId,
    required int limit,
    DateTime? cursor,
  });

  Future<int> seedDemoTransactions({required String userId});
}

class TransactionFirestoreDataSource implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore;

  const TransactionFirestoreDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> _collection(String userId) =>
      _firestore.collection('users').doc(userId).collection('transactions');

  @override
  Future<({List<TransactionModel> items, bool hasMore})> fetchPage({
    required String userId,
    required int limit,
    DateTime? cursor,
  }) async {
    Query<Map<String, dynamic>> query =
        _collection(userId).orderBy('date', descending: true);

    // Paginación por cursor: continúa después de la fecha del último elemento.
    if (cursor != null) {
      query = query.startAfter([Timestamp.fromDate(cursor)]);
    }

    // Se pide un documento extra para saber si quedan más páginas
    // sin necesidad de una consulta de conteo adicional.
    final snapshot = await query.limit(limit + 1).get();

    final docs = snapshot.docs;
    final hasMore = docs.length > limit;
    final page = hasMore ? docs.sublist(0, limit) : docs;

    return (
      items: page.map(TransactionModel.fromFirestore).toList(),
      hasMore: hasMore,
    );
  }

  @override
  Future<int> seedDemoTransactions({required String userId}) async {
    final collection = _collection(userId);

    // Evita duplicar si ya se sembró antes.
    final existing = await collection.limit(1).get();
    if (existing.docs.isNotEmpty) return 0;

    final batch = _firestore.batch();
    final now = DateTime.now();

    // Se crea también el documento padre `users/{uid}`. Firestore permite
    // subcolecciones bajo documentos inexistentes, pero entonces el padre
    // aparece vacío en la consola; escribirlo deja la estructura explícita.
    batch.set(
      _firestore.collection('users').doc(userId),
      {'seededAt': Timestamp.fromDate(now)},
      SetOptions(merge: true),
    );

    for (var i = 0; i < _demoSeeds.length; i++) {
      final seed = _demoSeeds[i];
      final model = TransactionModel(
        id: '',
        title: seed.title,
        description: seed.description,
        amount: seed.amount,
        kind: seed.kind,
        status: seed.status,
        // Fechas separadas por horas: garantiza un orden estable y un cursor
        // sin empates para la paginación.
        date: now.subtract(Duration(hours: i * 7 + 1)),
        category: seed.category,
      );
      batch.set(collection.doc(), model.toFirestore(userId: userId));
    }

    await batch.commit();
    return _demoSeeds.length;
  }
}

// ─── Datos de demostración (40 movimientos) ───────────────────────────────────

typedef _Seed = ({
  String title,
  String description,
  double amount,
  TransactionKind kind,
  TransactionStatus status,
  String category,
});

_Seed _s(
  String title,
  String description,
  double amount,
  TransactionKind kind,
  String category, [
  TransactionStatus status = TransactionStatus.completed,
]) =>
    (
      title: title,
      description: description,
      amount: amount,
      kind: kind,
      status: status,
      category: category
    );

final List<_Seed> _demoSeeds = [
  _s('Transferencia a María López', 'Pago alquiler', 3500.00, TransactionKind.transfer, 'Vivienda'),
  _s('Depósito de nómina', 'Salario quincenal', 12500.00, TransactionKind.deposit, 'Salario'),
  _s('Supermercado La Torre', 'Compras del hogar', 850.25, TransactionKind.payment, 'Alimentación'),
  _s('Retiro ATM', 'Cajero Centro Comercial', 2000.00, TransactionKind.withdrawal, 'Efectivo'),
  _s('Netflix', 'Suscripción mensual', 119.00, TransactionKind.payment, 'Entretenimiento'),
  _s('Transferencia de Carlos Pérez', 'Pago proyecto freelance', 5000.00, TransactionKind.income, 'Freelance'),
  _s('EMPAGUA', 'Servicio de agua', 175.00, TransactionKind.payment, 'Servicios', TransactionStatus.pending),
  _s('Uber', 'Viaje al aeropuerto', 145.50, TransactionKind.payment, 'Transporte'),
  _s('Farmacia Galeno', 'Medicamentos', 320.75, TransactionKind.payment, 'Salud'),
  _s('Transferencia a Ana Ruiz', 'Préstamo devuelto', 1200.00, TransactionKind.transfer, 'Personal'),
  _s('EEGSA', 'Energía eléctrica', 480.00, TransactionKind.payment, 'Servicios'),
  _s('Spotify', 'Plan familiar', 65.00, TransactionKind.payment, 'Entretenimiento'),
  _s('Depósito en efectivo', 'Agencia zona 10', 3000.00, TransactionKind.deposit, 'Efectivo'),
  _s('Restaurante Kacao', 'Cena familiar', 690.00, TransactionKind.payment, 'Alimentación'),
  _s('Gasolinera Puma', 'Combustible', 400.00, TransactionKind.payment, 'Transporte'),
  _s('Transferencia a Luis Gómez', 'Pago de servicios', 850.00, TransactionKind.transfer, 'Personal'),
  _s('Amazon', 'Compra de libros', 275.30, TransactionKind.payment, 'Compras'),
  _s('Retiro ATM', 'Cajero zona 15', 1500.00, TransactionKind.withdrawal, 'Efectivo'),
  _s('Claro', 'Plan de datos', 250.00, TransactionKind.payment, 'Servicios'),
  _s('Reembolso de gastos', 'Viáticos aprobados', 1800.00, TransactionKind.income, 'Trabajo'),
  _s('Cinépolis', 'Entradas de cine', 180.00, TransactionKind.payment, 'Entretenimiento'),
  _s('Transferencia a Pedro Díaz', 'División de cuenta', 425.00, TransactionKind.transfer, 'Personal'),
  _s('Walmart', 'Despensa mensual', 1650.40, TransactionKind.payment, 'Alimentación'),
  _s('Depósito de nómina', 'Salario quincenal', 12500.00, TransactionKind.deposit, 'Salario'),
  _s('Seguro médico', 'Prima mensual', 950.00, TransactionKind.payment, 'Salud'),
  _s('Gimnasio Sport Club', 'Mensualidad', 300.00, TransactionKind.payment, 'Salud'),
  _s('Transferencia de Sofía Mena', 'Regalo de cumpleaños', 500.00, TransactionKind.income, 'Personal'),
  _s('Retiro ATM', 'Cajero Miraflores', 800.00, TransactionKind.withdrawal, 'Efectivo'),
  _s('Librería Sophos', 'Material de estudio', 385.00, TransactionKind.payment, 'Educación'),
  _s('Colegio de Ingenieros', 'Cuota anual', 600.00, TransactionKind.payment, 'Profesional', TransactionStatus.pending),
  _s('Rappi', 'Pedido de comida', 165.90, TransactionKind.payment, 'Alimentación'),
  _s('Transferencia a Jorge Ríos', 'Pago de renta compartida', 2200.00, TransactionKind.transfer, 'Vivienda'),
  _s('Apple Store', 'Accesorios', 1120.00, TransactionKind.payment, 'Compras'),
  _s('Depósito de cheque', 'Cliente corporativo', 7500.00, TransactionKind.deposit, 'Trabajo'),
  _s('Tigo', 'Internet residencial', 375.00, TransactionKind.payment, 'Servicios'),
  _s('Óptica Visión', 'Lentes graduados', 1450.00, TransactionKind.payment, 'Salud'),
  _s('Transferencia a Elena Paz', 'Aporte familiar', 1000.00, TransactionKind.transfer, 'Personal'),
  _s('Cafetería &Café', 'Desayuno de trabajo', 95.00, TransactionKind.payment, 'Alimentación'),
  _s('Venta de equipo usado', 'Monitor y teclado', 1350.00, TransactionKind.income, 'Otros'),
  _s('Municipalidad', 'Impuesto único sobre inmuebles', 540.00, TransactionKind.payment, 'Impuestos'),
];
