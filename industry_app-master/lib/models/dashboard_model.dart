import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';


@JsonSerializable()
class DashboardModel {
  double total_weight;
  List<PickupSchedule> pickups;
  List<DayWiseDistribution> day_wise_waste;
  List<WasteRecoveryDistribution> monthly_category_distribution;


  DashboardModel(
      {required this.total_weight,
      required this.day_wise_waste,
      required this.monthly_category_distribution,
      required this.pickups,
      });
  factory DashboardModel.fromJson(Map<String, dynamic> json) => _$DashboardModelFromJson(json);

}


@JsonSerializable()
class DustbinData {
  int dustbin_id;
  String dustbin_name;
  String total_weight;
  String total_capacity;

  DustbinData(
      {required this.dustbin_id,
      required this.dustbin_name,
      required this.total_capacity,
      required this.total_weight});

  factory DustbinData.fromJson(Map<String, dynamic> json) => _$DustbinDataFromJson(json);
  //
  Map<String, dynamic> toJson() => _$DustbinDataToJson(this);
}


@JsonSerializable()
class PickupSchedule {
  int id;
  num total_weight;
  int total_location;
  DateTime pickup_date;

  PickupSchedule(
      {required this.id, required this.pickup_date, required this.total_weight,required this.total_location});

  factory PickupSchedule.fromJson(Map<String, dynamic> json) => _$PickupScheduleFromJson(json);
  //
  Map<String, dynamic> toJson() => _$PickupScheduleToJson(this);
}


@JsonSerializable()
class DayWiseDistribution {
  double total_weight;
  String date;

  DayWiseDistribution({required this.total_weight, required this.date});

  factory DayWiseDistribution.fromJson(Map<String, dynamic> json) =>
      _$DayWiseDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$DayWiseDistributionToJson(this);
}


@JsonSerializable()
class WasteRecoveryDistribution {
  double total_weight;
  String category_name;

  WasteRecoveryDistribution({required this.total_weight, required this.category_name});

  factory WasteRecoveryDistribution.fromJson(Map<String, dynamic> json) =>
      _$WasteRecoveryDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$WasteRecoveryDistributionToJson(this);
}



@JsonSerializable()
class Predictions{
  String date;
  double predicted_weight;
  Predictions({required this.date,required this.predicted_weight});
  factory Predictions.fromJson(Map<String, dynamic> json) => _$PredictionsFromJson(json);

}