import 'package:json_annotation/json_annotation.dart';
part 'statistics_model.g.dart';
@JsonSerializable()
class StatisticsModel {
  double daily_average_weigh;
  double highest_daily_waste;
  double last_week_waste;
  List<AverageWaste> average_waste;
  List<WasteDistribution> waste_distribution;
  List<RecoverDistribution> recovery_distribution;

  StatisticsModel({
    required this.average_waste,
    required this.daily_average_weigh,
    required this.highest_daily_waste,
    required this.last_week_waste,
    required this.recovery_distribution,
    required this.waste_distribution
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsModelToJson(this);
}
@JsonSerializable()
class AverageWaste {
  double quantity;
  int day;

  AverageWaste({required this.quantity, required this.day});
  factory AverageWaste.fromJson(Map<String, dynamic> json) =>
      _$AverageWasteFromJson(json);

  Map<String, dynamic> toJson() => _$AverageWasteToJson(this);

}
@JsonSerializable()
class WasteDistribution {
  double quantity;
  int dustbin_id;
  String dustbin_name;
  String day;

  WasteDistribution(
      {required this.day,
      required this.quantity,
      required this.dustbin_id,
      required this.dustbin_name});
  factory WasteDistribution.fromJson(Map<String, dynamic> json) =>
      _$WasteDistributionFromJson(json);

  static Map<String, dynamic> toJson(waste) => _$WasteDistributionToJson(waste);

}
@JsonSerializable()
class RecoverDistribution {
  double total_weight;
  String tag_name;
  int day;

  RecoverDistribution({required this.day, required this.total_weight, required this.tag_name});

  factory RecoverDistribution.fromJson(Map<String, dynamic> json) =>
      _$RecoverDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$RecoverDistributionToJson(this);
}
