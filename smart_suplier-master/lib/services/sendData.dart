import 'dart:convert';
import 'package:dio/dio.dart' as D;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/models/activity_model.dart';
import 'package:smart_bin/models/dashboard_model.dart';
import 'package:smart_bin/models/dustbin_details_model.dart';
import 'package:smart_bin/models/dustbin_model.dart';
import 'package:smart_bin/models/statistics_model.dart';
import 'package:smart_bin/models/transaction_model.dart';
import 'package:smart_bin/provider/ActivityProvider.dart';
import 'package:smart_bin/provider/DustbinDetailsProvider.dart';
import 'package:smart_bin/provider/DustbinProvider.dart';
import 'package:smart_bin/provider/HomeProvider.dart';
import 'package:smart_bin/provider/StatisticsProvider.dart';
import 'package:smart_bin/provider/TransactionProvider.dart';
import 'package:smart_bin/provider/UserProvider.dart';
import 'package:smart_bin/screens/food_category.dart';
import 'package:smart_bin/services/ApiBaseHelper.dart';
import 'package:smart_bin/services/api.dart';
import 'package:smart_bin/services/save_preference.dart';

import '../constant.dart';
import '../models/user_model.dart';
import '../screens/home_page/home_screen.dart';
import '../screens/otp/otp.dart';
import '../screens/signup_page/signup.dart';

User? user;

class SendData {
  Future<void> sendOtp(String phone, BuildContext context) async {
    await apiBaseHelper.postAPICall(send_otp, {'phone': phone}).then((getdata) {
      bool error = getdata["error"] ?? false;
      String? msg = getdata["message"];
      if (!error) {
        Navigator.pop(context);
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => OtpScreen(
                      phone: phone,
                    )));
      } else {
        Navigator.pop(context);
        return false;
      }
    }, onError: (error) {
      Navigator.pop(context);
      setSnackbar(error.toString(), context);
    });
  }

  Future verifyOtp(Map otp, context) async {
    var getdata = await apiBaseHelper.postAPICall(verify_otp, otp);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    Navigator.pop(context);
    if (getdata['code'] == 200) {
      print(getdata['code']);
      User user = User.fromJson(getdata['data']);
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(user);
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      settingProvider.saveUserDetail(user, context);
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    } else if (getdata['code'] == 201) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignUpScreen(phoneNo: otp['phone'])),
          (Route<dynamic> route) => false);
    } else {
      return msg ?? "An Error occurred";
    }
  }

  Future registerUser(Map details, context) async {
    var getdata = await apiBaseHelper.postAPICall(register_user, details);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    Navigator.pop(context);
    if (getdata['code'] == 200) {
      User user = User.fromJson(getdata['data']);
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      settingProvider.saveUserDetail(user, context);
      Navigator.pushNamedAndRemoveUntil(context, FoodCategory.routeName, (route) => false);
    } else {
      setSnackbar(msg ?? "An Error Occurred", context);
    }
  }
  Future getDashboardData(context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    var getdata = await apiBaseHelper.postAPICall(dashboard, {'producer_id': userId.toString()});
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (getdata['code'] == 200) {
      // print(getdata['data']);
      DashboardModel dashboardModel = DashboardModel.fromJson(getdata['data']);
      HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.setDashboard(dashboardModel);
      homeProvider.changeLoading();
    } else {
      setSnackbar(msg ?? "An Error Occurred", context);
    }
  }

  Future fetchStatistics(Map details, context) async {
    var getdata = await apiBaseHelper.postAPICall(user_statistics, details);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      StatisticsModel statistics = StatisticsModel.fromJson(getdata['data']);
      StatisticsProvider statisticsProvider =
          Provider.of<StatisticsProvider>(context, listen: false);
      statisticsProvider.setStatistics(statistics);
      statisticsProvider.stopLoading();
    } else {
      print(msg);
    }
  }

  Future getActivities(Map details, context) async {
    var getdata = await apiBaseHelper.postAPICall(user_activities, details);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      List<ActivityModel> activity = (getdata['data'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList();
      ActivityProvider activityProvider = Provider.of<ActivityProvider>(context, listen: false);
      activityProvider.setActivities(activity);
      activityProvider.stopLoading();
    } else {
      print(msg);
    }
  }

  Future<String?> updateProfile(Map details) async {
    Response response = await apiBaseHelper.postAPICall(update_profile, details);
    var getdata = json.decode(response.body);
    bool error = getdata["error"];
    String? msg = getdata["message"];
    if (!error) {
      return msg;
    } else {
      print(msg);
      return null;
    }
  }

  getTransaction(Map input, context) async {
    var getdata = await apiBaseHelper.postAPICall(transactions, input);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      List data = getdata['data'];
      print(data);
      List<TransactionModel> transactionList =
          data.map((e) => TransactionModel.fromJson(e)).toList();
      TransactionProvider transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);
      transactionProvider.setDashboard(transactionList);
      transactionProvider.changeLoading();
    } else {
      print(msg);
      return null;
    }
  }

  Future getDustbinById(context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    var dio = D.Dio();
    D.Response response =
    await dio.get(baseUrl + '/dustbin/get-my-dustbins/$userId');
    var getdata = response.data;

    // Uri dustbin_by_id = Uri.parse(baseUrl + '/dustbin/get-my-dustbins/$userId');
    // var getdata = await apiBaseHelper.getAPICall(dustbin_by_id);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      List<DustbinModel> dustbinList = (getdata['data'] as List<dynamic>)
          .map((e) => DustbinModel.fromJson(e as Map<String, dynamic>))
          .toList();
      DustbinProvider dustbinProvider = Provider.of<DustbinProvider>(context, listen: false);
      dustbinProvider.setDustbins(dustbinList);
      dustbinProvider.changeIsLoading();
    } else {
      print(msg);
    }
  }

  Future updateProducerProfile(Map details, context) async {
    var getdata = await apiBaseHelper.postAPICall(update_profile, details);
    Navigator.pop(context);
    bool error = getdata['error'] ?? false;
    if (!error) {
      print('Hello');
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setAddress(details['address']);
      userProvider.setName(details['name']);
      await settingProvider.setPrefrence('name', details['name']);
      await settingProvider.setPrefrence('address', details['address']);
      // settingProvider.saveUserDetail(userProvider.user, context);
    } else {
      print(getdata['msg']);
      setSnackbar(getdata['msg'], context);
    }
  }

  Future fetchDustbinDetails(dustbinId, context) async {
    Uri dustbin_by_id = Uri.parse(baseUrl + ' /dustbin/get-dustbin-detail/$dustbinId');

    var getdata = await apiBaseHelper.getAPICall(dustbin_by_id);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      DustbinDetailsModel dustbinDetails = DustbinDetailsModel.fromJson(getdata['data']);
      DustbinDetailsProvider dustbinProvider =
          Provider.of<DustbinDetailsProvider>(context, listen: false);
      dustbinProvider.setDustbins(dustbinDetails);
      dustbinProvider.stopLoading();
    } else {
      print(msg);
    }
  }

  Future addDustbin(String categoryId, String dustbin_name, context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    print({
      "category_id": categoryId,
      "dustbin_name": dustbin_name,
      "producer_id": userId.toString()
    });
    var getdata = await apiBaseHelper.postAPICall(add_dustbin, {
      "category_id": categoryId,
      "dustbin_name": dustbin_name,
      "producer_id": userId.toString()
    });
    Navigator.pop(context);
    bool error = getdata['error'] ?? false;
    if (!error && getdata['code'] == 200) {
      //Navigator.pop(context);
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      settingProvider.setPrefrenceBool('isCategory', true);
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    } else {
      print(getdata);
      setSnackbar(getdata['msg'], context);
    }
  }
}
