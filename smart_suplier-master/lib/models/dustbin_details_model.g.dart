// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dustbin_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DustbinDetailsModel _$DustbinDetailsModelFromJson(Map<String, dynamic> json) => DustbinDetailsModel(
      distribution: (json['distribution'] as List<dynamic>)
          .map((e) => Distribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      dustbin: DustbinModel.fromJson(json['dustbin'][0] as Map<String, dynamic>),
      last_week_waste: (json['last_week_waste'] as num).toDouble(),
      daily_average_weight: (json['daily_average_weight'] as num).toDouble(),
      dustbin_weight: (json['dustbin_weight'] as num).toDouble(),
      highest_daily_weight: (json['highest_daily_weight'] as num).toDouble(),
    );

Map<String, dynamic> _$DustbinDetailsModelToJson(DustbinDetailsModel instance) => <String, dynamic>{
      'dustbin_weight': instance.dustbin_weight,
      'daily_average_weight': instance.daily_average_weight,
      'highest_daily_weight': instance.highest_daily_weight,
      'last_week_waste': instance.last_week_waste,
      'dustbin': instance.dustbin,
      'distribution': instance.distribution,
    };

Distribution _$DistributionFromJson(Map<String, dynamic> json) => Distribution(
      dustbin_name: json['dustbin_name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      dustbin_id: json['dustbin_id'] as int,
      date: json['day'] as String,
    );

Map<String, dynamic> _$DistributionToJson(Distribution instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'dustbin_id': instance.dustbin_id,
      'dustbin_name': instance.dustbin_name,
      'date': instance.date,
    };
