// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      daywiseDistribution: (json['day_wise_distribution'] as List<dynamic>)
          .map((e) => DayWiseDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      dustbinData: (json['dustbin_data'] as List<dynamic>)
          .map((e) => DustbinData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pickupSchedule: (json['pickup_schedules'] as List<dynamic>)
          .map((e) => PickupSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalWeight: (json['total_weight'] as num).toDouble(),
      wasteRecovery: (json['monthly_distribution'] as List<dynamic>)
          .map((e) =>
              WasteRecoveryDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'totalWeight': instance.totalWeight,
      'dustbinData': instance.dustbinData,
      'pickupSchedule': instance.pickupSchedule,
      'daywiseDistribution': instance.daywiseDistribution,
      'wasteRecovery': instance.wasteRecovery,
    };

DustbinData _$DustbinDataFromJson(Map<String, dynamic> json) {
  print(json);
  return DustbinData(
    dustbin_id: json['dustbin_id'] as int,
    dustbin_name: json['dustbin_name'] as String,
    total_capacity: (json['total_capacity'] as num).toDouble(),
    total_weight: (json['total_weight'] as num).toDouble(),
  );
}

Map<String, dynamic> _$DustbinDataToJson(DustbinData instance) =>
    <String, dynamic>{
      'dustbin_id': instance.dustbin_id,
      'dustbin_name': instance.dustbin_name,
      'total_weight': instance.total_weight,
      'total_capacity': instance.total_capacity,
    };

PickupSchedule _$PickupScheduleFromJson(Map<String, dynamic> json) =>
    PickupSchedule(
      dustbin_name: json['dustbin_name'] as String,
      pickup_date: DateTime.parse(json['pickup_date'] as String),
      total_weight: (json['total_weight'] as num).toDouble(),
    );

Map<String, dynamic> _$PickupScheduleToJson(PickupSchedule instance) =>
    <String, dynamic>{
      'dustbin_name': instance.dustbin_name,
      'pickup_date': instance.pickup_date.toIso8601String(),
      'total_weight': instance.total_weight,
    };

DayWiseDistribution _$DayWiseDistributionFromJson(Map<String, dynamic> json) =>
    DayWiseDistribution(
      dustbin_name: json['dustbin_name'] as String,
      id: json['dustbin_id'] as int,
      quantity: (json['quantity'] as num).toDouble(),
      day: days[(json['day'] as String)]
    );

Map<String, dynamic> _$DayWiseDistributionToJson(
        DayWiseDistribution instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'id': instance.id,
      'dustbin_name': instance.dustbin_name,
    };

WasteRecoveryDistribution _$WasteRecoveryDistributionFromJson(
        Map<String, dynamic> json) =>
    WasteRecoveryDistribution(
      total_weight: (json['total_weight'] as num).toDouble(),
      tag_name: json['tag_name'] as String,
    );

Map<String, dynamic> _$WasteRecoveryDistributionToJson(
        WasteRecoveryDistribution instance) =>
    <String, dynamic>{
      'total_weight': instance.total_weight,
      'tag_name': instance.tag_name,
    };
