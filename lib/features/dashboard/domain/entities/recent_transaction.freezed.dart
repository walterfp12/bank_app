// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecentTransaction {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  TransactionKind get kind => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Create a copy of RecentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentTransactionCopyWith<RecentTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentTransactionCopyWith<$Res> {
  factory $RecentTransactionCopyWith(
    RecentTransaction value,
    $Res Function(RecentTransaction) then,
  ) = _$RecentTransactionCopyWithImpl<$Res, RecentTransaction>;
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
class _$RecentTransactionCopyWithImpl<$Res, $Val extends RecentTransaction>
    implements $RecentTransactionCopyWith<$Res> {
  _$RecentTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentTransaction
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
abstract class _$$RecentTransactionImplCopyWith<$Res>
    implements $RecentTransactionCopyWith<$Res> {
  factory _$$RecentTransactionImplCopyWith(
    _$RecentTransactionImpl value,
    $Res Function(_$RecentTransactionImpl) then,
  ) = __$$RecentTransactionImplCopyWithImpl<$Res>;
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
class __$$RecentTransactionImplCopyWithImpl<$Res>
    extends _$RecentTransactionCopyWithImpl<$Res, _$RecentTransactionImpl>
    implements _$$RecentTransactionImplCopyWith<$Res> {
  __$$RecentTransactionImplCopyWithImpl(
    _$RecentTransactionImpl _value,
    $Res Function(_$RecentTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecentTransaction
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
      _$RecentTransactionImpl(
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

class _$RecentTransactionImpl extends _RecentTransaction {
  const _$RecentTransactionImpl({
    required this.id,
    required this.title,
    required this.amount,
    required this.kind,
    required this.date,
  }) : super._();

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
    return 'RecentTransaction(id: $id, title: $title, amount: $amount, kind: $kind, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, amount, kind, date);

  /// Create a copy of RecentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentTransactionImplCopyWith<_$RecentTransactionImpl> get copyWith =>
      __$$RecentTransactionImplCopyWithImpl<_$RecentTransactionImpl>(
        this,
        _$identity,
      );
}

abstract class _RecentTransaction extends RecentTransaction {
  const factory _RecentTransaction({
    required final String id,
    required final String title,
    required final double amount,
    required final TransactionKind kind,
    required final DateTime date,
  }) = _$RecentTransactionImpl;
  const _RecentTransaction._() : super._();

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

  /// Create a copy of RecentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentTransactionImplCopyWith<_$RecentTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
