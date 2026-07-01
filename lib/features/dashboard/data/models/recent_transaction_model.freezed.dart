// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RecentTransactionModel _$RecentTransactionModelFromJson(
  Map<String, dynamic> json,
) {
  return _RecentTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$RecentTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  TransactionKind get kind => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this RecentTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecentTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentTransactionModelCopyWith<RecentTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentTransactionModelCopyWith<$Res> {
  factory $RecentTransactionModelCopyWith(
    RecentTransactionModel value,
    $Res Function(RecentTransactionModel) then,
  ) = _$RecentTransactionModelCopyWithImpl<$Res, RecentTransactionModel>;
  @useResult
  $Res call({
    String id,
    String title,
    double amount,
    TransactionKind kind,
    DateTime date,
  });
}

/// @nodoc
class _$RecentTransactionModelCopyWithImpl<
  $Res,
  $Val extends RecentTransactionModel
>
    implements $RecentTransactionModelCopyWith<$Res> {
  _$RecentTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? amount = null,
    Object? kind = null,
    Object? date = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as TransactionKind,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecentTransactionModelImplCopyWith<$Res>
    implements $RecentTransactionModelCopyWith<$Res> {
  factory _$$RecentTransactionModelImplCopyWith(
    _$RecentTransactionModelImpl value,
    $Res Function(_$RecentTransactionModelImpl) then,
  ) = __$$RecentTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    double amount,
    TransactionKind kind,
    DateTime date,
  });
}

/// @nodoc
class __$$RecentTransactionModelImplCopyWithImpl<$Res>
    extends
        _$RecentTransactionModelCopyWithImpl<$Res, _$RecentTransactionModelImpl>
    implements _$$RecentTransactionModelImplCopyWith<$Res> {
  __$$RecentTransactionModelImplCopyWithImpl(
    _$RecentTransactionModelImpl _value,
    $Res Function(_$RecentTransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecentTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? amount = null,
    Object? kind = null,
    Object? date = null,
  }) {
    return _then(
      _$RecentTransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as TransactionKind,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentTransactionModelImpl extends _RecentTransactionModel {
  const _$RecentTransactionModelImpl({
    required this.id,
    required this.title,
    required this.amount,
    required this.kind,
    required this.date,
  }) : super._();

  factory _$RecentTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final double amount;
  @override
  final TransactionKind kind;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'RecentTransactionModel(id: $id, title: $title, amount: $amount, kind: $kind, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, amount, kind, date);

  /// Create a copy of RecentTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentTransactionModelImplCopyWith<_$RecentTransactionModelImpl>
  get copyWith =>
      __$$RecentTransactionModelImplCopyWithImpl<_$RecentTransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentTransactionModelImplToJson(this);
  }
}

abstract class _RecentTransactionModel extends RecentTransactionModel {
  const factory _RecentTransactionModel({
    required final String id,
    required final String title,
    required final double amount,
    required final TransactionKind kind,
    required final DateTime date,
  }) = _$RecentTransactionModelImpl;
  const _RecentTransactionModel._() : super._();

  factory _RecentTransactionModel.fromJson(Map<String, dynamic> json) =
      _$RecentTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  double get amount;
  @override
  TransactionKind get kind;
  @override
  DateTime get date;

  /// Create a copy of RecentTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentTransactionModelImplCopyWith<_$RecentTransactionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
