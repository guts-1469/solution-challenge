import 'package:json_annotation/json_annotation.dart';
import 'package:smart_bin/models/statistics_model.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardModel {
  double totalWeight;
  List<DustbinData> dustbinData;
  List<PickupSchedule> pickupSchedule;
  List<DayWiseDistribution> daywiseDistribution;
  List<WasteRecoveryDistribution> wasteRecovery;

  DashboardModel(
      {required this.daywiseDistribution,
      required this.dustbinData,
      required this.pickupSchedule,
      required this.totalWeight,
      required this.wasteRecovery});
  factory DashboardModel.fromJson(Map<String, dynamic> json) => _$DashboardModelFromJson(json);

}

@JsonSerializable()
class DustbinData {
  int dustbin_id;
  String dustbin_name;
  double total_weight;
  double total_capacity;

  DustbinData(
      {required this.dustbin_id,
      required this.dustbin_name,
      required this.total_capacity,
      required this.total_weight});

  factory DustbinData.fromJson(Map<String, dynamic> json) => _$DustbinDataFromJson(json);

  Map<String, dynamic> toJson() => _$DustbinDataToJson(this);
}

@JsonSerializable()
class PickupSchedule {
  String dustbin_name;
  DateTime pickup_date;
  double total_weight;

  PickupSchedule(
      {required this.dustbin_name, required this.pickup_date, required this.total_weight});

  factory PickupSchedule.fromJson(Map<String, dynamic> json) => _$PickupScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$PickupScheduleToJson(this);
}

@JsonSerializable()
class DayWiseDistribution {
  double quantity;
  int id;
  String dustbin_name;
  int day;

  DayWiseDistribution({required this.dustbin_name, required this.id, required this.quantity,required this.day});

  factory DayWiseDistribution.fromJson(Map<String, dynamic> json) =>
      _$DayWiseDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$DayWiseDistributionToJson(this);
}

@JsonSerializable()
class WasteRecoveryDistribution {
  double total_weight;
  String tag_name;

  WasteRecoveryDistribution({required this.total_weight, required this.tag_name});

  factory WasteRecoveryDistribution.fromJson(Map<String, dynamic> json) =>
      _$WasteRecoveryDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$WasteRecoveryDistributionToJson(this);
}
