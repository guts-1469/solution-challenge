// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) => StatisticsModel(
      category_distribution: (json['category_distribution'] as List<dynamic>)
          .map((e) => CategoryDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      day_cost_distribution: (json['day_cost_distribution'] as List<dynamic>)
          .map((e) => DayCostDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      distance_distribution: (json['distance_distribution'] as List<dynamic>)
          .map((e) => DistanceDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_dustbin_pickups: json['total_dustbin_pickups'] == null
          ? DustbinPickUp(total_cost: 0, total_distance: 0, total_weight: 0)
          : DustbinPickUp.fromJson(json['total_dustbin_pickups'] as Map<String, dynamic>),
      food_waste_distribution: (json['food_waste_distribution'] as List<dynamic>)
          .map((e) => FoodWasteDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) => <String, dynamic>{
      'total_dustbin_pickups': instance.total_dustbin_pickups,
      'category_distribution': instance.category_distribution,
      'day_cost_distribution': instance.day_cost_distribution,
      'distance_distribution': instance.distance_distribution,
      'food_waste_distribution': instance.food_waste_distribution,
    };

CategoryDistribution _$CategoryDistributionFromJson(Map<String, dynamic> json) {
  return CategoryDistribution(
    total_weight: (json['total_weight'] as num).toDouble(),
    day: json['day'] as String,
    tag_name: json['tag_name'] as String,
  );
}

Map<String, dynamic> _$CategoryDistributionToJson(CategoryDistribution instance) =>
    <String, dynamic>{
      'total_weight': instance.total_weight,
      'tag_name': instance.tag_name,
      'day': instance.day,
    };

DayCostDistribution _$DayCostDistributionFromJson(Map<String, dynamic> json) {
  print(json);
  return DayCostDistribution(
    total_cost: (json['total_cost'] as num).toDouble(),
    date: json['date'] as String,
  );
}

FoodWasteDistribution _$FoodWasteDistributionFromJson(Map<String, dynamic> json) {
  print(json);
  return FoodWasteDistribution(
    total_weight: (json['total_weight'] as num).toDouble(),
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$DayCostDistributionToJson(DayCostDistribution instance) => <String, dynamic>{
      'total_cost': instance.total_cost,
      'date': instance.date,
    };

DistanceDistribution _$DistanceDistributionFromJson(Map<String, dynamic> json) =>
    DistanceDistribution(
      date: json['date'] as String,
      total_distance: (json['total_distance'] as num).toDouble(),
    );

Map<String, dynamic> _$DistanceDistributionToJson(DistanceDistribution instance) =>
    <String, dynamic>{
      'total_distance': instance.total_distance,
      'date': instance.date,
    };

DustbinPickUp _$DustbinPickUpFromJson(Map<String, dynamic> json) => DustbinPickUp(
      total_distance: (json['total_distance'] as num).toDouble(),
      total_cost: (json['total_cost'] as num).toDouble(),
      total_weight: (json['total_weight'] as num).toDouble(),
    );

Map<String, dynamic> _$DustbinPickUpToJson(DustbinPickUp instance) => <String, dynamic>{
      'total_distance': instance.total_distance,
      'total_weight': instance.total_weight,
      'total_cost': instance.total_cost,
    };
