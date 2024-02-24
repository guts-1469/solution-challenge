// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as int,
      category_image: json['category_image'] as String,
      category_name: json['category_name'] as String,
      updated_at: json['updated_at'] as String,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_image': instance.category_image,
      'category_name': instance.category_name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int,
      tagName: json['tagName'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };
