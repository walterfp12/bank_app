// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransactionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsEmpty value) empty,
    required TResult Function(TransactionsLoaded value) loaded,
    required TResult Function(TransactionsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsEmpty value)? empty,
    TResult? Function(TransactionsLoaded value)? loaded,
    TResult? Function(TransactionsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsEmpty value)? empty,
    TResult Function(TransactionsLoaded value)? loaded,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsStateCopyWith<$Res> {
  factory $TransactionsStateCopyWith(
    TransactionsState value,
    $Res Function(TransactionsState) then,
  ) = _$TransactionsStateCopyWithImpl<$Res, TransactionsState>;
}

/// @nodoc
class _$TransactionsStateCopyWithImpl<$Res, $Val extends TransactionsState>
    implements $TransactionsStateCopyWith<$Res> {
  _$TransactionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionsInitialImplCopyWith<$Res> {
  factory _$$TransactionsInitialImplCopyWith(
    _$TransactionsInitialImpl value,
    $Res Function(_$TransactionsInitialImpl) then,
  ) = __$$TransactionsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsInitialImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsInitialImpl>
    implements _$$TransactionsInitialImplCopyWith<$Res> {
  __$$TransactionsInitialImplCopyWithImpl(
    _$TransactionsInitialImpl _value,
    $Res Function(_$TransactionsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsInitialImpl implements TransactionsInitial {
  const _$TransactionsInitialImpl();

  @override
  String toString() {
    return 'TransactionsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsEmpty value) empty,
    required TResult Function(TransactionsLoaded value) loaded,
    required TResult Function(TransactionsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsEmpty value)? empty,
    TResult? Function(TransactionsLoaded value)? loaded,
    TResult? Function(TransactionsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsEmpty value)? empty,
    TResult Function(TransactionsLoaded value)? loaded,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TransactionsInitial implements TransactionsState {
  const factory TransactionsInitial() = _$TransactionsInitialImpl;
}

/// @nodoc
abstract class _$$TransactionsLoadingImplCopyWith<$Res> {
  factory _$$TransactionsLoadingImplCopyWith(
    _$TransactionsLoadingImpl value,
    $Res Function(_$TransactionsLoadingImpl) then,
  ) = __$$TransactionsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsLoadingImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsLoadingImpl>
    implements _$$TransactionsLoadingImplCopyWith<$Res> {
  __$$TransactionsLoadingImplCopyWithImpl(
    _$TransactionsLoadingImpl _value,
    $Res Function(_$TransactionsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsLoadingImpl implements TransactionsLoading {
  const _$TransactionsLoadingImpl();

  @override
  String toString() {
    return 'TransactionsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsEmpty value) empty,
    required TResult Function(TransactionsLoaded value) loaded,
    required TResult Function(TransactionsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsEmpty value)? empty,
    TResult? Function(TransactionsLoaded value)? loaded,
    TResult? Function(TransactionsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsEmpty value)? empty,
    TResult Function(TransactionsLoaded value)? loaded,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TransactionsLoading implements TransactionsState {
  const factory TransactionsLoading() = _$TransactionsLoadingImpl;
}

/// @nodoc
abstract class _$$TransactionsEmptyImplCopyWith<$Res> {
  factory _$$TransactionsEmptyImplCopyWith(
    _$TransactionsEmptyImpl value,
    $Res Function(_$TransactionsEmptyImpl) then,
  ) = __$$TransactionsEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsEmptyImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsEmptyImpl>
    implements _$$TransactionsEmptyImplCopyWith<$Res> {
  __$$TransactionsEmptyImplCopyWithImpl(
    _$TransactionsEmptyImpl _value,
    $Res Function(_$TransactionsEmptyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsEmptyImpl implements TransactionsEmpty {
  const _$TransactionsEmptyImpl();

  @override
  String toString() {
    return 'TransactionsState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TransactionsEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsEmpty value) empty,
    required TResult Function(TransactionsLoaded value) loaded,
    required TResult Function(TransactionsError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsEmpty value)? empty,
    TResult? Function(TransactionsLoaded value)? loaded,
    TResult? Function(TransactionsError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsEmpty value)? empty,
    TResult Function(TransactionsLoaded value)? loaded,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class TransactionsEmpty implements TransactionsState {
  const factory TransactionsEmpty() = _$TransactionsEmptyImpl;
}

/// @nodoc
abstract class _$$TransactionsLoadedImplCopyWith<$Res> {
  factory _$$TransactionsLoadedImplCopyWith(
    _$TransactionsLoadedImpl value,
    $Res Function(_$TransactionsLoadedImpl) then,
  ) = __$$TransactionsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<TransactionEntity> items,
    bool hasMore,
    bool isLoadingMore,
    DateTime? cursor,
    String? paginationError,
  });
}

/// @nodoc
class __$$TransactionsLoadedImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsLoadedImpl>
    implements _$$TransactionsLoadedImplCopyWith<$Res> {
  __$$TransactionsLoadedImplCopyWithImpl(
    _$TransactionsLoadedImpl _value,
    $Res Function(_$TransactionsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
    Object? cursor = freezed,
    Object? paginationError = freezed,
  }) {
    return _then(
      _$TransactionsLoadedImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TransactionEntity>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        cursor: freezed == cursor
            ? _value.cursor
            : cursor // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        paginationError: freezed == paginationError
            ? _value.paginationError
            : paginationError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TransactionsLoadedImpl implements TransactionsLoaded {
  const _$TransactionsLoadedImpl({
    required final List<TransactionEntity> items,
    required this.hasMore,
    this.isLoadingMore = false,
    this.cursor,
    this.paginationError,
  }) : _items = items;

  final List<TransactionEntity> _items;
  @override
  List<TransactionEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Quedan más páginas por traer.
  @override
  final bool hasMore;

  /// Se está trayendo la siguiente página (los items actuales siguen visibles).
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// Cursor de la siguiente página.
  @override
  final DateTime? cursor;

  /// Error al traer la siguiente página, sin perder lo ya cargado.
  @override
  final String? paginationError;

  @override
  String toString() {
    return 'TransactionsState.loaded(items: $items, hasMore: $hasMore, isLoadingMore: $isLoadingMore, cursor: $cursor, paginationError: $paginationError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsLoadedImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.cursor, cursor) || other.cursor == cursor) &&
            (identical(other.paginationError, paginationError) ||
                other.paginationError == paginationError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    hasMore,
    isLoadingMore,
    cursor,
    paginationError,
  );

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsLoadedImplCopyWith<_$TransactionsLoadedImpl> get copyWith =>
      __$$TransactionsLoadedImplCopyWithImpl<_$TransactionsLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(items, hasMore, isLoadingMore, cursor, paginationError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(items, hasMore, isLoadingMore, cursor, paginationError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(items, hasMore, isLoadingMore, cursor, paginationError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsEmpty value) empty,
    required TResult Function(TransactionsLoaded value) loaded,
    required TResult Function(TransactionsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsEmpty value)? empty,
    TResult? Function(TransactionsLoaded value)? loaded,
    TResult? Function(TransactionsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsEmpty value)? empty,
    TResult Function(TransactionsLoaded value)? loaded,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TransactionsLoaded implements TransactionsState {
  const factory TransactionsLoaded({
    required final List<TransactionEntity> items,
    required final bool hasMore,
    final bool isLoadingMore,
    final DateTime? cursor,
    final String? paginationError,
  }) = _$TransactionsLoadedImpl;

  List<TransactionEntity> get items;

  /// Quedan más páginas por traer.
  bool get hasMore;

  /// Se está trayendo la siguiente página (los items actuales siguen visibles).
  bool get isLoadingMore;

  /// Cursor de la siguiente página.
  DateTime? get cursor;

  /// Error al traer la siguiente página, sin perder lo ya cargado.
  String? get paginationError;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsLoadedImplCopyWith<_$TransactionsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionsErrorImplCopyWith<$Res> {
  factory _$$TransactionsErrorImplCopyWith(
    _$TransactionsErrorImpl value,
    $Res Function(_$TransactionsErrorImpl) then,
  ) = __$$TransactionsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TransactionsErrorImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsErrorImpl>
    implements _$$TransactionsErrorImplCopyWith<$Res> {
  __$$TransactionsErrorImplCopyWithImpl(
    _$TransactionsErrorImpl _value,
    $Res Function(_$TransactionsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$TransactionsErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TransactionsErrorImpl implements TransactionsError {
  const _$TransactionsErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'TransactionsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsErrorImplCopyWith<_$TransactionsErrorImpl> get copyWith =>
      __$$TransactionsErrorImplCopyWithImpl<_$TransactionsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(
      List<TransactionEntity> items,
      bool hasMore,
      bool isLoadingMore,
      DateTime? cursor,
      String? paginationError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsEmpty value) empty,
    required TResult Function(TransactionsLoaded value) loaded,
    required TResult Function(TransactionsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsEmpty value)? empty,
    TResult? Function(TransactionsLoaded value)? loaded,
    TResult? Function(TransactionsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsEmpty value)? empty,
    TResult Function(TransactionsLoaded value)? loaded,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TransactionsError implements TransactionsState {
  const factory TransactionsError({required final String message}) =
      _$TransactionsErrorImpl;

  String get message;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsErrorImplCopyWith<_$TransactionsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
