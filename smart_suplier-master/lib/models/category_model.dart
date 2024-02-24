
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';


@JsonSerializable()
class CategoryModel {
  int id;
  String category_image;
  String category_name;
  String created_at;
  String updated_at;

  CategoryModel({required this.id, required this.category_image, required this.category_name,required this.updated_at,required this.created_at});
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
  Tag(id: 2,tagName: 'Natural Gas'),
  Tag(id: 3, tagName: 'Fertilizer'),
  Tag(id: 4,tagName: 'Perfume'),
  Tag(id: 5, tagName: 'Aleo'),
];