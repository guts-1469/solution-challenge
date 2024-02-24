// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int,
      total_weight: (json['total_weight'] as num).toDouble(),
      total_location: json['total_location'] as int,
      pickup_date: DateTime.parse(json['pickup_date'] as String),
      categories_name: json['categories_name'] as String,
      consumer_id: json['consumer_id'] as int,
      pickup_status: json['pickup_status'] as int,
      time_from: json['time_from'] as String,
      time_to: json['time_to'] as String,
      total_cost: json['total_cost'] as int,
      total_distance: json['total_distance'] as num,
      total_dustbin: json['total_dustbin'] as int,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consumer_id': instance.consumer_id,
      'total_distance': instance.total_distance,
      'total_weight': instance.total_weight,
      'total_location': instance.total_location,
      'total_dustbin': instance.total_dustbin,
      'total_cost': instance.total_cost,
      'categories_name': instance.categories_name,
      'time_from': instance.time_from,
      'time_to': instance.time_to,
      'pickup_date': instance.pickup_date.toIso8601String(),
      'pickup_status': instance.pickup_status,
    };
