// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaymentCardModel _$PaymentCardModelFromJson(Map<String, dynamic> json) {
  return _PaymentCardModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentCardModel {
  String get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get holderName => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  CardType get type => throw _privateConstructorUsedError;
  CardBrand get brand => throw _privateConstructorUsedError;
  double? get creditLimit => throw _privateConstructorUsedError;
  double? get usedCredit => throw _privateConstructorUsedError;

  /// Serializes this PaymentCardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCardModelCopyWith<PaymentCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCardModelCopyWith<$Res> {
  factory $PaymentCardModelCopyWith(
    PaymentCardModel value,
    $Res Function(PaymentCardModel) then,
  ) = _$PaymentCardModelCopyWithImpl<$Res, PaymentCardModel>;
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
class _$PaymentCardModelCopyWithImpl<$Res, $Val extends PaymentCardModel>
    implements $PaymentCardModelCopyWith<$Res> {
  _$PaymentCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentCardModel
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
abstract class _$$PaymentCardModelImplCopyWith<$Res>
    implements $PaymentCardModelCopyWith<$Res> {
  factory _$$PaymentCardModelImplCopyWith(
    _$PaymentCardModelImpl value,
    $Res Function(_$PaymentCardModelImpl) then,
  ) = __$$PaymentCardModelImplCopyWithImpl<$Res>;
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
class __$$PaymentCardModelImplCopyWithImpl<$Res>
    extends _$PaymentCardModelCopyWithImpl<$Res, _$PaymentCardModelImpl>
    implements _$$PaymentCardModelImplCopyWith<$Res> {
  __$$PaymentCardModelImplCopyWithImpl(
    _$PaymentCardModelImpl _value,
    $Res Function(_$PaymentCardModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentCardModel
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
      _$PaymentCardModelImpl(
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
@JsonSerializable()
class _$PaymentCardModelImpl extends _PaymentCardModel {
  const _$PaymentCardModelImpl({
    required this.id,
    required this.number,
    required this.holderName,
    required this.expiryDate,
    required this.type,
    required this.brand,
    this.creditLimit,
    this.usedCredit,
  }) : super._();

  factory _$PaymentCardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentCardModelImplFromJson(json);

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
    return 'PaymentCardModel(id: $id, number: $number, holderName: $holderName, expiryDate: $expiryDate, type: $type, brand: $brand, creditLimit: $creditLimit, usedCredit: $usedCredit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentCardModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of PaymentCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentCardModelImplCopyWith<_$PaymentCardModelImpl> get copyWith =>
      __$$PaymentCardModelImplCopyWithImpl<_$PaymentCardModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentCardModelImplToJson(this);
  }
}

abstract class _PaymentCardModel extends PaymentCardModel {
  const factory _PaymentCardModel({
    required final String id,
    required final String number,
    required final String holderName,
    required final String expiryDate,
    required final CardType type,
    required final CardBrand brand,
    final double? creditLimit,
    final double? usedCredit,
  }) = _$PaymentCardModelImpl;
  const _PaymentCardModel._() : super._();

  factory _PaymentCardModel.fromJson(Map<String, dynamic> json) =
      _$PaymentCardModelImpl.fromJson;

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

  /// Create a copy of PaymentCardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentCardModelImplCopyWith<_$PaymentCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
