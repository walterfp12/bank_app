/// Modelo de tarjeta bancaria
enum CardType { debit, credit }

enum CardBrand { visa, mastercard }

class BankCard {
  final String id;
  final String cardNumber;
  final String holderName;
  final String expiryDate;
  final CardType type;
  final CardBrand brand;
  final double? creditLimit;
  final double? usedCredit;
  final bool isBlocked;
  final String linkedAccountId;

  const BankCard({
    required this.id,
    required this.cardNumber,
    required this.holderName,
    required this.expiryDate,
    required this.type,
    required this.brand,
    this.creditLimit,
    this.usedCredit,
    this.isBlocked = false,
    required this.linkedAccountId,
  });

  double get availableCredit {
    if (creditLimit == null || usedCredit == null) return 0;
    return creditLimit! - usedCredit!;
  }

  String get typeLabel => type == CardType.debit ? 'Débito' : 'Crédito';
  String get brandLabel =>
      brand == CardBrand.visa ? 'VISA' : 'MASTERCARD';

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      id: json['id'] as String,
      cardNumber: json['card_number'] as String,
      holderName: json['holder_name'] as String,
      expiryDate: json['expiry_date'] as String,
      type: CardType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CardType.debit,
      ),
      brand: CardBrand.values.firstWhere(
        (e) => e.name == json['brand'],
        orElse: () => CardBrand.visa,
      ),
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      usedCredit: (json['used_credit'] as num?)?.toDouble(),
      isBlocked: json['is_blocked'] as bool? ?? false,
      linkedAccountId: json['linked_account_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_number': cardNumber,
      'holder_name': holderName,
      'expiry_date': expiryDate,
      'type': type.name,
      'brand': brand.name,
      'credit_limit': creditLimit,
      'used_credit': usedCredit,
      'is_blocked': isBlocked,
      'linked_account_id': linkedAccountId,
    };
  }
}
