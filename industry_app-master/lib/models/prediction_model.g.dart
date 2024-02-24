// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionModel _$PredictionModelFromJson(Map<String, dynamic> json) =>
    PredictionModel(
      predicted_weight: (json['predicted_weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      selected_categories_name:
          (json['selected_categories_name'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      selected_dustbin_ids: (json['selected_dustbin_ids'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      selected_producers: (json['selected_producers'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$PredictionModelToJson(PredictionModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'predicted_weight': instance.predicted_weight,
      'selected_dustbin': instance.selected_dustbin_ids,
      'selected_producer': instance.selected_producers,
      'selected_categories_name': instance.selected_categories_name,
    };
