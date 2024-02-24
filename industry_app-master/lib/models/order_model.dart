import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';
@JsonSerializable()
class OrderModel {
  int id;
  int consumer_id;
  num total_distance;
  double total_weight;
  int total_location;
  int total_dustbin;
  int total_cost;
  String categories_name;
  String time_from;
  String time_to;
  DateTime pickup_date;
  int pickup_status;

  OrderModel(
      {required this.id,
      required this.total_weight,
      required this.total_location,
      required this.pickup_date,
      required this.categories_name,
      required this.consumer_id,
      required this.pickup_status,
      required this.time_from,
      required this.time_to,
      required this.total_cost,
      required this.total_distance,
      required this.total_dustbin});

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

}

