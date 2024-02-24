import 'package:json_annotation/json_annotation.dart';

part 'dustbin_location.g.dart';
@JsonSerializable()
class DustbinLocation {
  Producer producer;
  List<Dustbins> dustbins;
  DustbinLocation({required this.producer,required this.dustbins});
  factory DustbinLocation.fromJson(Map<String, dynamic> json) => _$DustbinLocationFromJson(json);

}
@JsonSerializable()
class Dustbins {
  int id;
  int pickup_id;
  int consumer_id;
  int dustbin_id;
  int category_id;
  DateTime from_date;
  DateTime to_date;
  double total_weight;
  num total_cost;
  DateTime pickup_at;
  String category_name;

  Dustbins({    required this.total_weight,
    required this.total_cost,
    required this.consumer_id,
    required this.id,
    required this.category_name,
    required this.dustbin_id,
    required this.category_id,
    required this.from_date,
    required this.pickup_at,
    required this.pickup_id,
    required this.to_date,
  });

  factory Dustbins.fromJson(Map<String, dynamic> json) => _$DustbinsFromJson(json);

}
@JsonSerializable()
class Producer {
  int id;
  String name;
  String phone;
  String address;
  double lat;
  double lng;
  int picked_status;

  Producer(
      {required this.id,
      required this.address,
      required this.name,
      required this.lng,
      required this.lat,
      required this.phone,
      required this.picked_status});

  factory Producer.fromJson(Map<String, dynamic> json) => _$ProducerFromJson(json);
}
