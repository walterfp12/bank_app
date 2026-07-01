import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card.freezed.dart';

/// Tipo de tarjeta — permite mostrar distintos tipos en el dashboard (HU 3.2)
enum CardType { debit, credit, prepaid }

/// Marca / red de la tarjeta
enum CardBrand { visa, mastercard, amex }

/// Entidad de tarjeta — capa Domain (Freezed).
///
/// El getter [availableCredit] es lógica de negocio pura de la entidad.
@freezed
class PaymentCard with _$PaymentCard {
  const PaymentCard._();

  const factory PaymentCard({
    required String id,
    required String number,
    required String holderName,
    required String expiryDate,
    required CardType type,
    required CardBrand brand,
    double? creditLimit,
    double? usedCredit,
  }) = _PaymentCard;

  /// Crédito disponible (0 si no es tarjeta de crédito).
  double get availableCredit {
    final limit = creditLimit;
    final used = usedCredit;
    if (limit == null || used == null) return 0;
    return limit - used;
  }
}
