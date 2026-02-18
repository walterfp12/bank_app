/// Modelo de cuenta bancaria
enum AccountType { savings, checking, credit }

class BankAccount {
  final String id;
  final String accountNumber;
  final String accountName;
  final AccountType type;
  final double balance;
  final double availableBalance;
  final String currency;
  final bool isActive;

  const BankAccount({
    required this.id,
    required this.accountNumber,
    required this.accountName,
    required this.type,
    required this.balance,
    required this.availableBalance,
    this.currency = 'GTQ',
    this.isActive = true,
  });

  String get typeLabel {
    switch (type) {
      case AccountType.savings:
        return 'Cuenta de Ahorro';
      case AccountType.checking:
        return 'Cuenta Corriente';
      case AccountType.credit:
        return 'Tarjeta de Crédito';
    }
  }

  String get typeIcon {
    switch (type) {
      case AccountType.savings:
        return '🏦';
      case AccountType.checking:
        return '💼';
      case AccountType.credit:
        return '💳';
    }
  }

  BankAccount copyWith({
    String? id,
    String? accountNumber,
    String? accountName,
    AccountType? type,
    double? balance,
    double? availableBalance,
    String? currency,
    bool? isActive,
  }) {
    return BankAccount(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      availableBalance: availableBalance ?? this.availableBalance,
      currency: currency ?? this.currency,
      isActive: isActive ?? this.isActive,
    );
  }

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'] as String,
      accountNumber: json['account_number'] as String,
      accountName: json['account_name'] as String,
      type: AccountType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AccountType.savings,
      ),
      balance: (json['balance'] as num).toDouble(),
      availableBalance: (json['available_balance'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'GTQ',
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber,
      'account_name': accountName,
      'type': type.name,
      'balance': balance,
      'available_balance': availableBalance,
      'currency': currency,
      'is_active': isActive,
    };
  }
}
