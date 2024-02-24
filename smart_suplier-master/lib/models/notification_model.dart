import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';


@JsonSerializable()
class NotificationModel {
  int id;
  String notification_title;
  String notification_type;
  int is_read;
  // String created_at;

  NotificationModel(
      {required this.id,
        required this.notification_title,
        required this.notification_type,
        // required this.created_at,
        required this.is_read});
  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

}
