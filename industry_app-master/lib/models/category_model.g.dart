// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id']==null?0:json['id'] as int,
      category_image: json['category_image'] as String,
      category_name: json['category_name'] as String,
    );
MyCategoryModel _$MyCategoryModelFromJson(Map<String, dynamic> json) =>
    MyCategoryModel(
      category_id: json['category_id'] as int,
      category_image: json['category_image'] as String,
      category_name: json['category_name'] as String,
        price_per_unit: json['price_per_unit'] as String
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      // 'category_image': instance.category_image,
      'category_name': instance.category_name,

    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int,
      tagName: json['tagName'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };
