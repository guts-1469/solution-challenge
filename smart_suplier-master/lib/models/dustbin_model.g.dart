// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dustbin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DustbinModel _$DustbinModelFromJson(Map<String, dynamic> json) => DustbinModel(
      id: json['id'] as int,
      created_at: DateTime.parse(json['created_at'] as String),
      category_name: json['category_name']??"Food Grain" as String,
      current_depth: json['current_depth'] as int,
      dustbin_name: json['dustbin_name'] as String,
      dustbin_status: json['dustbin_status'] as int,
      total_capacity: (json['total_capacity'] as num).toDouble(),

      current_capacity: (json['current_capacity'] as num).toDouble(),
    );

Map<String, dynamic> _$DustbinModelToJson(DustbinModel instance) =>
    <String, dynamic>{
      'dustbin_name': instance.dustbin_name,
      'category_id': instance.category_name,
      'total_capacity': instance.total_capacity,
      'current_depth': instance.current_depth,
      'dustbin_status': instance.dustbin_status,
      'id': instance.id,
      'created_at': instance.created_at,
    };
