// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) {
  return _AuthSessionModel.fromJson(json);
}

/// @nodoc
mixin _$AuthSessionModel {
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this AuthSessionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthSessionModelCopyWith<AuthSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSessionModelCopyWith<$Res> {
  factory $AuthSessionModelCopyWith(
    AuthSessionModel value,
    $Res Function(AuthSessionModel) then,
  ) = _$AuthSessionModelCopyWithImpl<$Res, AuthSessionModel>;
  @useResult
  $Res call({
    int userId,
    String username,
    String email,
    String firstName,
    String lastName,
    String image,
    String accessToken,
    String refreshToken,
    String expiresAt,
  });
}

/// @nodoc
class _$AuthSessionModelCopyWithImpl<$Res, $Val extends AuthSessionModel>
    implements $AuthSessionModelCopyWith<$Res> {
  _$AuthSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? image = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            image: null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String,
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthSessionModelImplCopyWith<$Res>
    implements $AuthSessionModelCopyWith<$Res> {
  factory _$$AuthSessionModelImplCopyWith(
    _$AuthSessionModelImpl value,
    $Res Function(_$AuthSessionModelImpl) then,
  ) = __$$AuthSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    String username,
    String email,
    String firstName,
    String lastName,
    String image,
    String accessToken,
    String refreshToken,
    String expiresAt,
  });
}

/// @nodoc
class __$$AuthSessionModelImplCopyWithImpl<$Res>
    extends _$AuthSessionModelCopyWithImpl<$Res, _$AuthSessionModelImpl>
    implements _$$AuthSessionModelImplCopyWith<$Res> {
  __$$AuthSessionModelImplCopyWithImpl(
    _$AuthSessionModelImpl _value,
    $Res Function(_$AuthSessionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? image = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresAt = null,
  }) {
    return _then(
      _$AuthSessionModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        image: null == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String,
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthSessionModelImpl extends _AuthSessionModel {
  const _$AuthSessionModelImpl({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  }) : super._();

  factory _$AuthSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthSessionModelImplFromJson(json);

  @override
  final int userId;
  @override
  final String username;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String image;
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String expiresAt;

  @override
  String toString() {
    return 'AuthSessionModel(userId: $userId, username: $username, email: $email, firstName: $firstName, lastName: $lastName, image: $image, accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSessionModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    username,
    email,
    firstName,
    lastName,
    image,
    accessToken,
    refreshToken,
    expiresAt,
  );

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSessionModelImplCopyWith<_$AuthSessionModelImpl> get copyWith =>
      __$$AuthSessionModelImplCopyWithImpl<_$AuthSessionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthSessionModelImplToJson(this);
  }
}

abstract class _AuthSessionModel extends AuthSessionModel {
  const factory _AuthSessionModel({
    required final int userId,
    required final String username,
    required final String email,
    required final String firstName,
    required final String lastName,
    required final String image,
    required final String accessToken,
    required final String refreshToken,
    required final String expiresAt,
  }) = _$AuthSessionModelImpl;
  const _AuthSessionModel._() : super._();

  factory _AuthSessionModel.fromJson(Map<String, dynamic> json) =
      _$AuthSessionModelImpl.fromJson;

  @override
  int get userId;
  @override
  String get username;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get image;
  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  String get expiresAt;

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSessionModelImplCopyWith<_$AuthSessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
