// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int,
      notification_title: json['notification_title'] as String,
      notification_type: json['notification_type'] as String,
      is_read: json['is_read'] as int,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notification_title': instance.notification_title,
      'notification_type': instance.notification_type,
      'is_read': instance.is_read,
    };
