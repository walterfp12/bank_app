// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PushMessageModelImpl _$$PushMessageModelImplFromJson(
  Map<String, dynamic> json,
) => _$PushMessageModelImpl(
  id: json['id'] as String,
  title: json['title'] as String? ?? '',
  body: json['body'] as String? ?? '',
  receivedAt: DateTime.parse(json['receivedAt'] as String),
  data:
      (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$$PushMessageModelImplToJson(
  _$PushMessageModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'receivedAt': instance.receivedAt.toIso8601String(),
  'data': instance.data,
};
