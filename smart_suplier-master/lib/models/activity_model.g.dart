// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as int,
      activity_title: json['activity_title'] as String,
      activity_type: json['activity_type'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      is_read: json['is_read'] as int,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity_title': instance.activity_title,
      'activity_type': instance.activity_type,
      'is_read': instance.is_read,
      'created_at': instance.created_at.toIso8601String(),
    };
