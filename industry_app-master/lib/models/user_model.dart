import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


class User {
   int id;
   String name;
   String phone;
   String address;
   double lng;
   double lat;
   String auth;
   String token;

  User({

    required this.auth,
    required this.lat,
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.lng,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
