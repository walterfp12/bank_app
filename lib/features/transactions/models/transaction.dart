/// Modelo de transacción bancaria
enum TransactionType { transfer, deposit, withdrawal, payment, income }

enum TransactionStatus { completed, pending, failed, cancelled }

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final TransactionType type;
  final TransactionStatus status;
  final DateTime date;
  final String? fromAccountId;
  final String? toAccountId;
  final String? recipientName;
  final String? category;
  final String? reference;

  const Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    required this.status,
    required this.date,
    this.fromAccountId,
    this.toAccountId,
    this.recipientName,
    this.category,
    this.reference,
  });

  bool get isIncome =>
      type == TransactionType.deposit || type == TransactionType.income;

  bool get isExpense =>
      type == TransactionType.withdrawal ||
      type == TransactionType.payment ||
      type == TransactionType.transfer;

  String get statusLabel {
    switch (status) {
      case TransactionStatus.completed:
        return 'Completada';
      case TransactionStatus.pending:
        return 'Pendiente';
      case TransactionStatus.failed:
        return 'Fallida';
      case TransactionStatus.cancelled:
        return 'Cancelada';
    }
  }

  String get typeLabel {
    switch (type) {
      case TransactionType.transfer:
        return 'Transferencia';
      case TransactionType.deposit:
        return 'Depósito';
      case TransactionType.withdrawal:
        return 'Retiro';
      case TransactionType.payment:
        return 'Pago';
      case TransactionType.income:
        return 'Ingreso';
    }
  }

  String get typeIcon {
    switch (type) {
      case TransactionType.transfer:
        return '↔️';
      case TransactionType.deposit:
        return '⬇️';
      case TransactionType.withdrawal:
        return '⬆️';
      case TransactionType.payment:
        return '💳';
      case TransactionType.income:
        return '💰';
    }
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.payment,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.completed,
      ),
      date: DateTime.parse(json['date'] as String),
      fromAccountId: json['from_account_id'] as String?,
      toAccountId: json['to_account_id'] as String?,
      recipientName: json['recipient_name'] as String?,
      category: json['category'] as String?,
      reference: json['reference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'type': type.name,
      'status': status.name,
      'date': date.toIso8601String(),
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'recipient_name': recipientName,
      'category': category,
      'reference': reference,
    };
  }
}
