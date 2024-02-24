import 'package:json_annotation/json_annotation.dart';

part 'statistics_model.g.dart';

@JsonSerializable()
class StatisticsModel {
  DustbinPickUp total_dustbin_pickups;
  List<CategoryDistribution> category_distribution;
  List<DayCostDistribution> day_cost_distribution;
  List<DistanceDistribution> distance_distribution;
  List<FoodWasteDistribution> food_waste_distribution;

  StatisticsModel(
      {required this.category_distribution,
      required this.day_cost_distribution,
      required this.distance_distribution,
      required this.total_dustbin_pickups,
      required this.food_waste_distribution});
  factory StatisticsModel.fromJson(Map<String, dynamic> json) => _$StatisticsModelFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticsModelToJson(this);

}

@JsonSerializable()
class CategoryDistribution {
  double total_weight;
  String tag_name;
  String day;

  CategoryDistribution({required this.total_weight, required this.day, required this.tag_name});
  factory CategoryDistribution.fromJson(Map<String, dynamic> json) => _$CategoryDistributionFromJson(json);

}

@JsonSerializable()
class DayCostDistribution {
  double total_cost;
  String date;

  DayCostDistribution({required this.total_cost, required this.date});
  factory DayCostDistribution.fromJson(Map<String, dynamic> json) => _$DayCostDistributionFromJson(json);

}
@JsonSerializable()
class FoodWasteDistribution {
  double total_weight;
  String date;

  FoodWasteDistribution({required this.total_weight, required this.date});
  factory FoodWasteDistribution.fromJson(Map<String, dynamic> json) => _$FoodWasteDistributionFromJson(json);

}
@JsonSerializable()
class DistanceDistribution {
  double total_distance;
  String date;

  DistanceDistribution({required this.date, required this.total_distance});
  factory DistanceDistribution.fromJson(Map<String, dynamic> json) => _$DistanceDistributionFromJson(json);

}

@JsonSerializable()
class DustbinPickUp {
  double total_distance;
  double total_weight;
  double total_cost;

  DustbinPickUp(
      {required this.total_distance, required this.total_cost, required this.total_weight});

  factory DustbinPickUp.fromJson(Map<String, dynamic> json) => _$DustbinPickUpFromJson(json);


}
