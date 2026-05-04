// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthSessionModelImpl _$$AuthSessionModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthSessionModelImpl(
  userId: (json['userId'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  image: json['image'] as String,
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$$AuthSessionModelImplToJson(
  _$AuthSessionModelImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'username': instance.username,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'image': instance.image,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresAt': instance.expiresAt,
};
