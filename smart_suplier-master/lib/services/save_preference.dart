import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../provider/UserProvider.dart';

class SettingProvider {
  late SharedPreferences _sharedPreferences;

  SettingProvider(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  //String? curCurrency = '';

  // String? curCartCount = "";
  // String? curBalance = '';
  // String? returnDay = '';
  // String? maxItems = '';
  // String? referCode = '';
  // String? minAmt = '';
  // String? curDeliveryCharge = '';
  // String? curPinCode = '';
  //
  // String? curTicketId = '';
  //
  // bool isFlatDel = true;
  // bool extendImg = true;
  // bool cartBtnList = true;
  // bool refer = true;

  String get phone => _sharedPreferences.getString("phone") ?? "";

  int? get userId => _sharedPreferences.getInt("id");

  String get userName => _sharedPreferences.getString("name") ?? "";

  String get address => _sharedPreferences.getString("address") ?? "";

  int get greenBalance => _sharedPreferences.getInt("greenBalance") ?? 0;

  int get walletBalance => _sharedPreferences.getInt("walletBalance") ?? 0;

  //bool get isLogIn => _sharedPreferences.getBool(isLogin) ?? false;

  setPrefrence(String key, String value) {
    _sharedPreferences.setString(key, value);
  }

  Future<String?> getPrefrence(String key) async {
    return _sharedPreferences.getString(key);
  }

  void setPrefrenceBool(String key, bool value) async {
    _sharedPreferences.setBool(key, value);
  }

  setPrefrenceList(String key, String query) async {
    List<String> valueList = await getPrefrenceList(key);
    if (!valueList.contains(query)) {
      if (valueList.length > 4) valueList.removeAt(0);
      valueList.add(query);

      _sharedPreferences.setStringList(key, valueList);
    }
  }

  Future<List<String>> getPrefrenceList(String key) async {
    return _sharedPreferences.getStringList(key) ?? [];
  }

  Future<bool> getPrefrenceBool(String key) async {
    return _sharedPreferences.getBool(key) ?? false;
  }

  Future<void> clearUserSession(BuildContext context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setName("");
    userProvider.setAddress("");
    userProvider.setAuth("");
    userProvider.setGreenBalance(0);
    userProvider.setLatLang(0, 0);
    userProvider.setWalletBalance(0);
    userProvider.setPhone("");
    await _sharedPreferences.clear();
  }

  Future<void> saveUserDetail(User user, BuildContext context) async {
    final waitList = <Future<void>>[];

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    waitList.add(_sharedPreferences.setInt("id", user.id));
    waitList.add(_sharedPreferences.setString("name", user.name));
    waitList.add(_sharedPreferences.setString("phone", user.phone));
    waitList.add(_sharedPreferences.setString("address", user.address));
    waitList.add(_sharedPreferences.setInt("walletBalance", user.wallet_balance));
    waitList.add(_sharedPreferences.setInt("greenBalance", user.green_balance));
    waitList.add(_sharedPreferences.setDouble("lng", user.lng));
    waitList.add(_sharedPreferences.setDouble("lat", user.lat));
    waitList.add(_sharedPreferences.setString("auth", user.auth));
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setName(user.name);
    userProvider.setAddress(user.address);
    userProvider.setAuth(user.auth);
    userProvider.setGreenBalance(user.green_balance);
    userProvider.setLatLang(user.lat, user.lng);
    userProvider.setWalletBalance(user.wallet_balance);
    userProvider.setPhone(user.phone);

    await Future.wait(waitList);
  }
}
