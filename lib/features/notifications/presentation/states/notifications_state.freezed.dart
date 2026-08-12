// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionDenied,
    required TResult Function(String token, List<PushMessage> messages) ready,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionDenied,
    TResult? Function(String token, List<PushMessage> messages)? ready,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionDenied,
    TResult Function(String token, List<PushMessage> messages)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsPermissionDenied value)
    permissionDenied,
    required TResult Function(NotificationsReady value) ready,
    required TResult Function(NotificationsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult? Function(NotificationsReady value)? ready,
    TResult? Function(NotificationsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult Function(NotificationsReady value)? ready,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsStateCopyWith<$Res> {
  factory $NotificationsStateCopyWith(
    NotificationsState value,
    $Res Function(NotificationsState) then,
  ) = _$NotificationsStateCopyWithImpl<$Res, NotificationsState>;
}

/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res, $Val extends NotificationsState>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotificationsInitialImplCopyWith<$Res> {
  factory _$$NotificationsInitialImplCopyWith(
    _$NotificationsInitialImpl value,
    $Res Function(_$NotificationsInitialImpl) then,
  ) = __$$NotificationsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsInitialImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsInitialImpl>
    implements _$$NotificationsInitialImplCopyWith<$Res> {
  __$$NotificationsInitialImplCopyWithImpl(
    _$NotificationsInitialImpl _value,
    $Res Function(_$NotificationsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationsInitialImpl implements NotificationsInitial {
  const _$NotificationsInitialImpl();

  @override
  String toString() {
    return 'NotificationsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionDenied,
    required TResult Function(String token, List<PushMessage> messages) ready,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionDenied,
    TResult? Function(String token, List<PushMessage> messages)? ready,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionDenied,
    TResult Function(String token, List<PushMessage> messages)? ready,
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
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsPermissionDenied value)
    permissionDenied,
    required TResult Function(NotificationsReady value) ready,
    required TResult Function(NotificationsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult? Function(NotificationsReady value)? ready,
    TResult? Function(NotificationsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult Function(NotificationsReady value)? ready,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NotificationsInitial implements NotificationsState {
  const factory NotificationsInitial() = _$NotificationsInitialImpl;
}

/// @nodoc
abstract class _$$NotificationsLoadingImplCopyWith<$Res> {
  factory _$$NotificationsLoadingImplCopyWith(
    _$NotificationsLoadingImpl value,
    $Res Function(_$NotificationsLoadingImpl) then,
  ) = __$$NotificationsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsLoadingImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsLoadingImpl>
    implements _$$NotificationsLoadingImplCopyWith<$Res> {
  __$$NotificationsLoadingImplCopyWithImpl(
    _$NotificationsLoadingImpl _value,
    $Res Function(_$NotificationsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationsLoadingImpl implements NotificationsLoading {
  const _$NotificationsLoadingImpl();

  @override
  String toString() {
    return 'NotificationsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionDenied,
    required TResult Function(String token, List<PushMessage> messages) ready,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionDenied,
    TResult? Function(String token, List<PushMessage> messages)? ready,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionDenied,
    TResult Function(String token, List<PushMessage> messages)? ready,
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
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsPermissionDenied value)
    permissionDenied,
    required TResult Function(NotificationsReady value) ready,
    required TResult Function(NotificationsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult? Function(NotificationsReady value)? ready,
    TResult? Function(NotificationsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult Function(NotificationsReady value)? ready,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NotificationsLoading implements NotificationsState {
  const factory NotificationsLoading() = _$NotificationsLoadingImpl;
}

/// @nodoc
abstract class _$$NotificationsPermissionDeniedImplCopyWith<$Res> {
  factory _$$NotificationsPermissionDeniedImplCopyWith(
    _$NotificationsPermissionDeniedImpl value,
    $Res Function(_$NotificationsPermissionDeniedImpl) then,
  ) = __$$NotificationsPermissionDeniedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsPermissionDeniedImplCopyWithImpl<$Res>
    extends
        _$NotificationsStateCopyWithImpl<
          $Res,
          _$NotificationsPermissionDeniedImpl
        >
    implements _$$NotificationsPermissionDeniedImplCopyWith<$Res> {
  __$$NotificationsPermissionDeniedImplCopyWithImpl(
    _$NotificationsPermissionDeniedImpl _value,
    $Res Function(_$NotificationsPermissionDeniedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationsPermissionDeniedImpl
    implements NotificationsPermissionDenied {
  const _$NotificationsPermissionDeniedImpl();

  @override
  String toString() {
    return 'NotificationsState.permissionDenied()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsPermissionDeniedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionDenied,
    required TResult Function(String token, List<PushMessage> messages) ready,
    required TResult Function(String message) error,
  }) {
    return permissionDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionDenied,
    TResult? Function(String token, List<PushMessage> messages)? ready,
    TResult? Function(String message)? error,
  }) {
    return permissionDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionDenied,
    TResult Function(String token, List<PushMessage> messages)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsPermissionDenied value)
    permissionDenied,
    required TResult Function(NotificationsReady value) ready,
    required TResult Function(NotificationsError value) error,
  }) {
    return permissionDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult? Function(NotificationsReady value)? ready,
    TResult? Function(NotificationsError value)? error,
  }) {
    return permissionDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult Function(NotificationsReady value)? ready,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied(this);
    }
    return orElse();
  }
}

abstract class NotificationsPermissionDenied implements NotificationsState {
  const factory NotificationsPermissionDenied() =
      _$NotificationsPermissionDeniedImpl;
}

/// @nodoc
abstract class _$$NotificationsReadyImplCopyWith<$Res> {
  factory _$$NotificationsReadyImplCopyWith(
    _$NotificationsReadyImpl value,
    $Res Function(_$NotificationsReadyImpl) then,
  ) = __$$NotificationsReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token, List<PushMessage> messages});
}

/// @nodoc
class __$$NotificationsReadyImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsReadyImpl>
    implements _$$NotificationsReadyImplCopyWith<$Res> {
  __$$NotificationsReadyImplCopyWithImpl(
    _$NotificationsReadyImpl _value,
    $Res Function(_$NotificationsReadyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? messages = null}) {
    return _then(
      _$NotificationsReadyImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<PushMessage>,
      ),
    );
  }
}

/// @nodoc

class _$NotificationsReadyImpl implements NotificationsReady {
  const _$NotificationsReadyImpl({
    required this.token,
    final List<PushMessage> messages = const <PushMessage>[],
  }) : _messages = messages;

  /// Token FCM de este dispositivo.
  @override
  final String token;

  /// Mensajes recibidos, del más reciente al más antiguo.
  final List<PushMessage> _messages;

  /// Mensajes recibidos, del más reciente al más antiguo.
  @override
  @JsonKey()
  List<PushMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'NotificationsState.ready(token: $token, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsReadyImpl &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    token,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsReadyImplCopyWith<_$NotificationsReadyImpl> get copyWith =>
      __$$NotificationsReadyImplCopyWithImpl<_$NotificationsReadyImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionDenied,
    required TResult Function(String token, List<PushMessage> messages) ready,
    required TResult Function(String message) error,
  }) {
    return ready(token, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionDenied,
    TResult? Function(String token, List<PushMessage> messages)? ready,
    TResult? Function(String message)? error,
  }) {
    return ready?.call(token, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionDenied,
    TResult Function(String token, List<PushMessage> messages)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(token, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsPermissionDenied value)
    permissionDenied,
    required TResult Function(NotificationsReady value) ready,
    required TResult Function(NotificationsError value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult? Function(NotificationsReady value)? ready,
    TResult? Function(NotificationsError value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult Function(NotificationsReady value)? ready,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class NotificationsReady implements NotificationsState {
  const factory NotificationsReady({
    required final String token,
    final List<PushMessage> messages,
  }) = _$NotificationsReadyImpl;

  /// Token FCM de este dispositivo.
  String get token;

  /// Mensajes recibidos, del más reciente al más antiguo.
  List<PushMessage> get messages;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsReadyImplCopyWith<_$NotificationsReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotificationsErrorImplCopyWith<$Res> {
  factory _$$NotificationsErrorImplCopyWith(
    _$NotificationsErrorImpl value,
    $Res Function(_$NotificationsErrorImpl) then,
  ) = __$$NotificationsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NotificationsErrorImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsErrorImpl>
    implements _$$NotificationsErrorImplCopyWith<$Res> {
  __$$NotificationsErrorImplCopyWithImpl(
    _$NotificationsErrorImpl _value,
    $Res Function(_$NotificationsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NotificationsErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NotificationsErrorImpl implements NotificationsError {
  const _$NotificationsErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'NotificationsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsErrorImplCopyWith<_$NotificationsErrorImpl> get copyWith =>
      __$$NotificationsErrorImplCopyWithImpl<_$NotificationsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionDenied,
    required TResult Function(String token, List<PushMessage> messages) ready,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionDenied,
    TResult? Function(String token, List<PushMessage> messages)? ready,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionDenied,
    TResult Function(String token, List<PushMessage> messages)? ready,
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
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsPermissionDenied value)
    permissionDenied,
    required TResult Function(NotificationsReady value) ready,
    required TResult Function(NotificationsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult? Function(NotificationsReady value)? ready,
    TResult? Function(NotificationsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsPermissionDenied value)? permissionDenied,
    TResult Function(NotificationsReady value)? ready,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NotificationsError implements NotificationsState {
  const factory NotificationsError({required final String message}) =
      _$NotificationsErrorImpl;

  String get message;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsErrorImplCopyWith<_$NotificationsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
