// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaymentCard {
  String get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get holderName => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  CardType get type => throw _privateConstructorUsedError;
  CardBrand get brand => throw _privateConstructorUsedError;
  double? get creditLimit => throw _privateConstructorUsedError;
  double? get usedCredit => throw _privateConstructorUsedError;

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCardCopyWith<PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCardCopyWith<$Res> {
  factory $PaymentCardCopyWith(
    PaymentCard value,
    $Res Function(PaymentCard) then,
  ) = _$PaymentCardCopyWithImpl<$Res, PaymentCard>;
  @useResult
  $Res call({
    String id,
    String number,
    String holderName,
    String expiryDate,
    CardType type,
    CardBrand brand,
    double? creditLimit,
    double? usedCredit,
  });
}

/// @nodoc
class _$PaymentCardCopyWithImpl<$Res, $Val extends PaymentCard>
    implements $PaymentCardCopyWith<$Res> {
  _$PaymentCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? holderName = null,
    Object? expiryDate = null,
    Object? type = null,
    Object? brand = null,
    Object? creditLimit = freezed,
    Object? usedCredit = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String,
            holderName: null == holderName
                ? _value.holderName
                : holderName // ignore: cast_nullable_to_non_nullable
                      as String,
            expiryDate: null == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CardType,
            brand: null == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as CardBrand,
            creditLimit: freezed == creditLimit
                ? _value.creditLimit
                : creditLimit // ignore: cast_nullable_to_non_nullable
                      as double?,
            usedCredit: freezed == usedCredit
                ? _value.usedCredit
                : usedCredit // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentCardImplCopyWith<$Res>
    implements $PaymentCardCopyWith<$Res> {
  factory _$$PaymentCardImplCopyWith(
    _$PaymentCardImpl value,
    $Res Function(_$PaymentCardImpl) then,
  ) = __$$PaymentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String number,
    String holderName,
    String expiryDate,
    CardType type,
    CardBrand brand,
    double? creditLimit,
    double? usedCredit,
  });
}

/// @nodoc
class __$$PaymentCardImplCopyWithImpl<$Res>
    extends _$PaymentCardCopyWithImpl<$Res, _$PaymentCardImpl>
    implements _$$PaymentCardImplCopyWith<$Res> {
  __$$PaymentCardImplCopyWithImpl(
    _$PaymentCardImpl _value,
    $Res Function(_$PaymentCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? holderName = null,
    Object? expiryDate = null,
    Object? type = null,
    Object? brand = null,
    Object? creditLimit = freezed,
    Object? usedCredit = freezed,
  }) {
    return _then(
      _$PaymentCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
        holderName: null == holderName
            ? _value.holderName
            : holderName // ignore: cast_nullable_to_non_nullable
                  as String,
        expiryDate: null == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CardType,
        brand: null == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as CardBrand,
        creditLimit: freezed == creditLimit
            ? _value.creditLimit
            : creditLimit // ignore: cast_nullable_to_non_nullable
                  as double?,
        usedCredit: freezed == usedCredit
            ? _value.usedCredit
            : usedCredit // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$PaymentCardImpl extends _PaymentCard {
  const _$PaymentCardImpl({
    required this.id,
    required this.number,
    required this.holderName,
    required this.expiryDate,
    required this.type,
    required this.brand,
    this.creditLimit,
    this.usedCredit,
  }) : super._();

  @override
  final String id;
  @override
  final String number;
  @override
  final String holderName;
  @override
  final String expiryDate;
  @override
  final CardType type;
  @override
  final CardBrand brand;
  @override
  final double? creditLimit;
  @override
  final double? usedCredit;

  @override
  String toString() {
    return 'PaymentCard(id: $id, number: $number, holderName: $holderName, expiryDate: $expiryDate, type: $type, brand: $brand, creditLimit: $creditLimit, usedCredit: $usedCredit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.holderName, holderName) ||
                other.holderName == holderName) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.usedCredit, usedCredit) ||
                other.usedCredit == usedCredit));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    number,
    holderName,
    expiryDate,
    type,
    brand,
    creditLimit,
    usedCredit,
  );

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentCardImplCopyWith<_$PaymentCardImpl> get copyWith =>
      __$$PaymentCardImplCopyWithImpl<_$PaymentCardImpl>(this, _$identity);
}

abstract class _PaymentCard extends PaymentCard {
  const factory _PaymentCard({
    required final String id,
    required final String number,
    required final String holderName,
    required final String expiryDate,
    required final CardType type,
    required final CardBrand brand,
    final double? creditLimit,
    final double? usedCredit,
  }) = _$PaymentCardImpl;
  const _PaymentCard._() : super._();

  @override
  String get id;
  @override
  String get number;
  @override
  String get holderName;
  @override
  String get expiryDate;
  @override
  CardType get type;
  @override
  CardBrand get brand;
  @override
  double? get creditLimit;
  @override
  double? get usedCredit;

  /// Create a copy of PaymentCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentCardImplCopyWith<_$PaymentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
