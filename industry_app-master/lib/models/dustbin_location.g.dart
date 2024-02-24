// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dustbin_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DustbinLocation _$DustbinLocationFromJson(Map<String, dynamic> json) {
  print(json['producer']);
  return DustbinLocation(
    producer: json['producer'] == null
        ? Producer(id: 0, address: "", name: "", lng: 0.0, lat: 0.0, phone: "", picked_status: 0)
        : Producer.fromJson(json['producer'] as Map<String, dynamic>),
    dustbins: (json['dustbins'] as List<dynamic>)
        .map((e) => Dustbins.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DustbinLocationToJson(DustbinLocation instance) => <String, dynamic>{
      'producer': instance.producer,
      'dustbins': instance.dustbins,
    };

Dustbins _$DustbinsFromJson(Map<String, dynamic> json) => Dustbins(
      total_weight: (json['total_weight'] as num).toDouble(),
      total_cost: json['total_cost'] as num,
      consumer_id: json['consumer_id'] as int,
      id: json['id'] as int,
      category_name: json['category_name'] as String,
      dustbin_id: json['dustbin_id'] as int,
      category_id: json['category_id'] as int,
      from_date: DateTime.parse(json['from_date'] as String),
      pickup_at: DateTime.parse(json['pickup_at'] as String),
      pickup_id: json['pickup_id'] as int,
      to_date: DateTime.parse(json['to_date'] as String),
    );

Map<String, dynamic> _$DustbinsToJson(Dustbins instance) => <String, dynamic>{
      'id': instance.id,
      'pickup_id': instance.pickup_id,
      'consumer_id': instance.consumer_id,
      'dustbin_id': instance.dustbin_id,
      'category_id': instance.category_id,
      'from_date': instance.from_date.toIso8601String(),
      'to_date': instance.to_date.toIso8601String(),
      'total_weight': instance.total_weight,
      'total_cost': instance.total_cost,
      'pickup_at': instance.pickup_at.toIso8601String(),
      'category_name': instance.category_name,
    };

Producer _$ProducerFromJson(Map<String, dynamic> json) => Producer(
      id: json['id'] as int,
      address: json['address'] as String,
      name: json['name'] as String,
      lng: (json['lng'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      phone: json['phone'] as String,
      picked_status: json['picked_status'] ?? 0 as int,
    );

Map<String, dynamic> _$ProducerToJson(Producer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'picked_status': instance.picked_status,
    };
