// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) =>
    StatisticsModel(
      average_waste: (json['average_waste'] as List<dynamic>)
          .map((e) => AverageWaste.fromJson(e as Map<String, dynamic>))
          .toList(),
      daily_average_weigh: (json['daily_average_weight'] as num).toDouble(),
      highest_daily_waste: (json['highest_daily_waste'] as num).toDouble(),
      last_week_waste: (json['last_week_waste'] as num).toDouble(),
      recovery_distribution: (json['recovery_distribution'] as List<dynamic>)
          .map((e) => RecoverDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      waste_distribution: (json['waste_distribution'] as List<dynamic>)
          .map((e) => WasteDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) =>
    <String, dynamic>{
      'daily_average_weigh': instance.daily_average_weigh,
      'highest_daily_waste': instance.highest_daily_waste,
      'last_week_waste': instance.last_week_waste,
      'average_waste': instance.average_waste,
      'waste_distribution': instance.waste_distribution,
      'recovery_distribution': instance.recovery_distribution,
    };

AverageWaste _$AverageWasteFromJson(Map<String, dynamic> json) => AverageWaste(
      quantity: (json['quantity'] as num).toDouble(),
      day: days[json['day']] as int,
    );

Map<String, dynamic> _$AverageWasteToJson(AverageWaste instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'day': instance.day,
    };

WasteDistribution _$WasteDistributionFromJson(Map<String, dynamic> json) =>
    WasteDistribution(
      day: json['day'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      dustbin_id: (json['dustbin_id'] as num).toInt(),
      dustbin_name: json['dustbin_name'] as String,
    );

Map<String, dynamic> _$WasteDistributionToJson(WasteDistribution instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'dustbin_id': instance.dustbin_id,
      'dustbin_name': instance.dustbin_name,
      'day': instance.day,
    };

RecoverDistribution _$RecoverDistributionFromJson(Map<String, dynamic> json) =>
    RecoverDistribution(
      day: days[json['day']] as int,
      total_weight: (json['total_weight'] as num).toDouble(),
      tag_name: json['tag_name'] as String,
    );

Map<String, dynamic> _$RecoverDistributionToJson(
        RecoverDistribution instance) =>
    <String, dynamic>{
      'total_weight': instance.total_weight,
      'tag_name': instance.tag_name,
      'day': instance.day,
    };
Map days={
  'Mon':0,
  'Tue':1,
  'Wed':2,
  'Thu':3,
  'Fri':4,
  'Sat':5,
  'Sun':6
};