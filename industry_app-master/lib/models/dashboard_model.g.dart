// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      total_weight: (json['total_weight'] as num).toDouble(),
      day_wise_waste: (json['day_wise_waste'] as List<dynamic>)
          .map((e) => DayWiseDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthly_category_distribution:
          (json['monthly_category_distribution'] as List<dynamic>)
              .map((e) =>
                  WasteRecoveryDistribution.fromJson(e as Map<String, dynamic>))
              .toList(),
      pickups: (json['pickups'] as List<dynamic>)
          .map((e) => PickupSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
     );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'total_weight': instance.total_weight,
      'pickups': instance.pickups,
      'day_wise_waste': instance.day_wise_waste,
      'monthly_category_distribution': instance.monthly_category_distribution,
    };

DustbinData _$DustbinDataFromJson(Map<String, dynamic> json) => DustbinData(
      dustbin_id: json['dustbin_id'] as int,
      dustbin_name: json['dustbin_name'] as String,
      total_capacity: json['total_capacity'] as String,
      total_weight: json['total_weight'] as String,
    );

Map<String, dynamic> _$DustbinDataToJson(DustbinData instance) =>
    <String, dynamic>{
      'dustbin_id': instance.dustbin_id,
      'dustbin_name': instance.dustbin_name,
      'total_weight': instance.total_weight,
      'total_capacity': instance.total_capacity,
    };

PickupSchedule _$PickupScheduleFromJson(Map<String, dynamic> json) =>
    PickupSchedule(
      id: json['id'] as int,
      pickup_date: DateTime.parse(json['pickup_date'] as String),
      total_weight: json['total_weight'] as num,
      total_location: json['total_location'] as int,
    );

Map<String, dynamic> _$PickupScheduleToJson(PickupSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_weight': instance.total_weight,
      'total_location': instance.total_location,
      'pickup_date': instance.pickup_date.toIso8601String(),
    };

DayWiseDistribution _$DayWiseDistributionFromJson(Map<String, dynamic> json) =>
    DayWiseDistribution(
      total_weight: (json['total_weight'] as int).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$DayWiseDistributionToJson(
        DayWiseDistribution instance) =>
    <String, dynamic>{
      'total_weight': instance.total_weight,
      'date': instance.date,
    };

WasteRecoveryDistribution _$WasteRecoveryDistributionFromJson(
        Map<String, dynamic> json) =>
    WasteRecoveryDistribution(
      total_weight: (json['total_weight'] as num).toDouble(),
      category_name: json['category_name'] as String,
    );

Map<String, dynamic> _$WasteRecoveryDistributionToJson(
        WasteRecoveryDistribution instance) =>
    <String, dynamic>{
      'total_weight': instance.total_weight,
      'category_name': instance.category_name,
    };

Predictions _$PredictionsFromJson(Map<String, dynamic> json) => Predictions(
      date: json['date'] as String,
      predicted_weight: (json['predicted_weight'] as num).toDouble(),
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'date': instance.date,
      'predicted_weight': instance.predicted_weight,
    };
