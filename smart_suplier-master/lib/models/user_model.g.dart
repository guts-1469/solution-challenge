// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      wallet_balance: json['wallet_balance'] as int,
      auth: json['auth'] as String,
      lat: (json['lat'] as num).toDouble(),
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      green_balance: json['green_balance'] as int,
      lng: (json['lng'] as num).toDouble(),
   );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'wallet_balance': instance.wallet_balance,
      'green_balance': instance.green_balance,
      'lng': instance.lng,
      'lat': instance.lat,
      'auth': instance.auth,
    };
