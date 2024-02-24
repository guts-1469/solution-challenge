import 'package:json_annotation/json_annotation.dart';
import 'package:smart_bin/models/dustbin_model.dart';

part 'dustbin_details_model.g.dart';

@JsonSerializable()
class DustbinDetailsModel {
  double dustbin_weight;
  double daily_average_weight;
  double highest_daily_weight;
  double last_week_waste;
  DustbinModel dustbin;
  List<Distribution> distribution;

  DustbinDetailsModel(
      {required this.distribution,
      required this.dustbin,
      required this.last_week_waste,
      required this.daily_average_weight,
      required this.dustbin_weight,
      required this.highest_daily_weight});

  factory DustbinDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DustbinDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DustbinDetailsModelToJson(this);
}

@JsonSerializable()
class Distribution {
  double quantity;
  int dustbin_id;
  String dustbin_name;
  String date;

  Distribution(
      {required this.dustbin_name,
      required this.quantity,
      required this.dustbin_id,
      required this.date});

  factory Distribution.fromJson(Map<String, dynamic> json) => _$DistributionFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionToJson(this);
}
