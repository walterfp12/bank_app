// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthSessionModelImpl _$$AuthSessionModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthSessionModelImpl(
  userId: json['userId'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String? ?? '',
  photoUrl: json['photoUrl'] as String? ?? '',
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String? ?? '',
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$$AuthSessionModelImplToJson(
  _$AuthSessionModelImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresAt': instance.expiresAt,
};
