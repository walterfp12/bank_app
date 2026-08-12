// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransactionPage {
  List<TransactionEntity> get items => throw _privateConstructorUsedError;

  /// Indica si quedan más documentos por traer.
  bool get hasMore => throw _privateConstructorUsedError;

  /// Cursor para la siguiente página (null si ya no hay más).
  DateTime? get nextCursor => throw _privateConstructorUsedError;

  /// Create a copy of TransactionPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionPageCopyWith<TransactionPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionPageCopyWith<$Res> {
  factory $TransactionPageCopyWith(
    TransactionPage value,
    $Res Function(TransactionPage) then,
  ) = _$TransactionPageCopyWithImpl<$Res, TransactionPage>;
  @useResult
  $Res call({
    List<TransactionEntity> items,
    bool hasMore,
    DateTime? nextCursor,
  });
}

/// @nodoc
class _$TransactionPageCopyWithImpl<$Res, $Val extends TransactionPage>
    implements $TransactionPageCopyWith<$Res> {
  _$TransactionPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? nextCursor = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TransactionEntity>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            nextCursor: freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionPageImplCopyWith<$Res>
    implements $TransactionPageCopyWith<$Res> {
  factory _$$TransactionPageImplCopyWith(
    _$TransactionPageImpl value,
    $Res Function(_$TransactionPageImpl) then,
  ) = __$$TransactionPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TransactionEntity> items,
    bool hasMore,
    DateTime? nextCursor,
  });
}

/// @nodoc
class __$$TransactionPageImplCopyWithImpl<$Res>
    extends _$TransactionPageCopyWithImpl<$Res, _$TransactionPageImpl>
    implements _$$TransactionPageImplCopyWith<$Res> {
  __$$TransactionPageImplCopyWithImpl(
    _$TransactionPageImpl _value,
    $Res Function(_$TransactionPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? nextCursor = freezed,
  }) {
    return _then(
      _$TransactionPageImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TransactionEntity>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        nextCursor: freezed == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$TransactionPageImpl implements _TransactionPage {
  const _$TransactionPageImpl({
    required final List<TransactionEntity> items,
    required this.hasMore,
    this.nextCursor,
  }) : _items = items;

  final List<TransactionEntity> _items;
  @override
  List<TransactionEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Indica si quedan más documentos por traer.
  @override
  final bool hasMore;

  /// Cursor para la siguiente página (null si ya no hay más).
  @override
  final DateTime? nextCursor;

  @override
  String toString() {
    return 'TransactionPage(items: $items, hasMore: $hasMore, nextCursor: $nextCursor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionPageImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    hasMore,
    nextCursor,
  );

  /// Create a copy of TransactionPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionPageImplCopyWith<_$TransactionPageImpl> get copyWith =>
      __$$TransactionPageImplCopyWithImpl<_$TransactionPageImpl>(
        this,
        _$identity,
      );
}

abstract class _TransactionPage implements TransactionPage {
  const factory _TransactionPage({
    required final List<TransactionEntity> items,
    required final bool hasMore,
    final DateTime? nextCursor,
  }) = _$TransactionPageImpl;

  @override
  List<TransactionEntity> get items;

  /// Indica si quedan más documentos por traer.
  @override
  bool get hasMore;

  /// Cursor para la siguiente página (null si ya no hay más).
  @override
  DateTime? get nextCursor;

  /// Create a copy of TransactionPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionPageImplCopyWith<_$TransactionPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
