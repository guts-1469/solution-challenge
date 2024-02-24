import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';


@JsonSerializable()
class ActivityModel {
  int id;
  String activity_title;
  String activity_type;
  int is_read;
  DateTime created_at;

  ActivityModel(
      {required this.id,
      required this.activity_title,
      required this.activity_type,
      required this.created_at,
      required this.is_read});
  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

}
