// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(

      auth: json['auth'] as String,
      lat: (json['lat'] as num).toDouble(),
      id: json['id'] as int,
      name: json['consumer_name'] as String,
      phone: json['consumer_phone'] as String,
      address: json['consumer_address'] as String,
      lng: (json['lng'] as num).toDouble(),
      token: json['token']??"" as String,

    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'lng': instance.lng,
      'lat': instance.lat,
      'auth': instance.auth,
      'token': instance.token,
    };
