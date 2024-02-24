import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: 0,
    name: '',
    phone: '',
    address: '',
    wallet_balance: 0,
    green_balance: 0,
    lng: 0.0,
    lat: 0.0,
    auth: '',
  );

  int get id => _user.id;

  String get name => _user.name;

  String get phone => _user.phone;

  String get address => _user.address;

  int get walletBalance => _user.wallet_balance;

  int get greenBalance => _user.green_balance;

  List get location => [_user.lat, _user.lng];

  String get authToken => _user.auth;

  User get user=>_user;
  void setId(int id) {
    _user.id = id;
    notifyListeners();
  }


  void setName(String name) {
    _user.name = name;
    notifyListeners();
  }

  void setPhone(String phone) {
    _user.phone = phone;
    notifyListeners();
  }

  void setAddress(String address) {
    _user.address = address;
    notifyListeners();
  }

  void setGreenBalance(int greenBalance) {
    _user.green_balance = greenBalance;
    notifyListeners();
  }

  void setWalletBalance(int walletBalance) {
    _user.wallet_balance = walletBalance;
    notifyListeners();
  }

  void setLatLang(double lat, double lang) {
    _user.lat = lat;
    _user.lng = lang;
    notifyListeners();
  }

  void setAuth(String auth) {
    _user.auth = auth;
    notifyListeners();
  }
  void setUser(User user){
    _user=user;
    notifyListeners();
  }
}
