import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
   int id;
   String name;
   String phone;
   String address;
   int wallet_balance;
   int green_balance;
   double lng;
   double lat;
   String auth;

  User({
    required this.wallet_balance,
    required this.auth,
    required this.lat,
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.green_balance,
    required this.lng,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
