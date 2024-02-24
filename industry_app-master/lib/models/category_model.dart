
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';


@JsonSerializable()
class CategoryModel {
  int id;
  String category_image;
  String category_name;
  // String price_per_unit;

  CategoryModel({required this.id,
    required this.category_image,
    required this.category_name,
    // required this.price_per_unit
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

}
@JsonSerializable()
class Tag{
  int id;
  String tagName;
  Tag({required this.id,required this.tagName});
}

List<Tag>tags=[
  Tag(id: 1, tagName: 'Bio Gas'),
  Tag(id: 2, tagName: 'Fertilizer'),

];
@JsonSerializable()
class MyCategoryModel {
  int category_id;
  String category_image;
  String category_name;
  String price_per_unit;

  MyCategoryModel({required this.category_id,
    required this.category_image,
    required this.category_name,
    required this.price_per_unit
  });
  factory MyCategoryModel.fromJson(Map<String, dynamic> json) => _$MyCategoryModelFromJson(json);
  // Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

}