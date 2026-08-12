import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Modelo de transacción – capa Data (Freezed + JSON).
///
/// Conoce el formato de Firestore: convierte el `Timestamp` nativo a `DateTime`
/// y de vuelta. La entidad de dominio nunca ve tipos de Firestore.
@freezed
class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  const factory TransactionModel({
    required String id,
    required String title,
    @Default('') String description,
    required double amount,
    required TransactionKind kind,
    @Default(TransactionStatus.completed) TransactionStatus status,
    required DateTime date,
    @Default('') String category,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  /// Construye el modelo desde un documento de Firestore.
  factory TransactionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};

    return TransactionModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0,
      kind: _kindFrom(data['kind'] as String?),
      status: _statusFrom(data['status'] as String?),
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: data['category'] as String? ?? '',
    );
  }

  /// Mapa listo para escribir en Firestore (el id va en el documento, no dentro).
  Map<String, dynamic> toFirestore({required String userId}) => {
        'userId': userId,
        'title': title,
        'description': description,
        'amount': amount,
        'kind': kind.name,
        'status': status.name,
        'date': Timestamp.fromDate(date),
        'category': category,
      };

  TransactionEntity toDomain() => TransactionEntity(
        id: id,
        title: title,
        description: description,
        amount: amount,
        kind: kind,
        status: status,
        date: date,
        category: category,
      );

  static TransactionKind _kindFrom(String? value) =>
      TransactionKind.values.firstWhere(
        (k) => k.name == value,
        orElse: () => TransactionKind.payment,
      );

  static TransactionStatus _statusFrom(String? value) =>
      TransactionStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () => TransactionStatus.completed,
      );
}
