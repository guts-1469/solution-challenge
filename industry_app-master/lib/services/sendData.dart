import 'dart:convert';

import 'package:dio/dio.dart' as D;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:industry_app/models/category_model.dart';
import 'package:industry_app/models/dustbin_location.dart';
import 'package:industry_app/models/prediction_model.dart';
import 'package:industry_app/provider/CategoryProvider.dart';
import 'package:industry_app/provider/DustbinLocationProvider.dart';
import 'package:industry_app/provider/MyCategoryProvider.dart';
import 'package:industry_app/provider/PredictionProvider.dart';
import 'package:industry_app/screens/food_category.dart';
import 'package:industry_app/services/save_preference.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/activity_model.dart';
import '../models/dashboard_model.dart';
import '../models/order_model.dart';
import '../models/statistics_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../provider/ActivityProvider.dart';
import '../provider/HomeProvider.dart';
import '../provider/OrderProvider.dart';
import '../provider/StatisticsProvider.dart';
import '../provider/TransactionProvider.dart';
import '../provider/UserProvider.dart';
import '../screens/home_page/home_screen.dart';
import '../screens/otp/otp.dart';
import '../screens/signup_page/signup.dart';
import 'ApiBaseHelper.dart';
import 'api.dart';

User? user;

class SendData {
  Future<void> sendOtp(String phone, BuildContext context) async {
    await apiBaseHelper.postAPICall(send_otp, {'consumer_phone': phone}).then((getdata) {
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
        print(msg);
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
      print(getdata);
      print(getdata['code']);
      User user = User.fromJson(getdata['data']);
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      settingProvider.saveUserDetail(user, context);
      settingProvider.setPrefrenceBool("isCategory", true);
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    } else if (getdata['code'] == 201) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignUpScreen(phoneNo: otp['consumer_phone'])),
          (Route<dynamic> route) => false);
    } else {
      return msg ?? "An Error occurred";
    }
  }

  Future registerUser(Map details, context) async {
    print(details);
    var dio = D.Dio();
    D.Response response =
        await dio.post(baseUrl + '/consumer/auth/register-account', data: details);
    var getdata = response.data;

    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    // Navigator.pop(context);
    if (getdata['code'] == 200) {
      User user = User.fromJson(getdata['data']);
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      settingProvider.saveUserDetail(user, context);
      Navigator.pushNamedAndRemoveUntil(context, FoodCategory.routeName, (route) => false);
    } else {
      setSnackbar(msg ?? "An Error Occurred", context);
    }
  }

  getUserCategories(context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;

    var getdata =
        await apiBaseHelper.postAPICall(get_my_category, {'consumer_id': userId.toString()});
    bool error = getdata['error'] ?? false;
    if (getdata['code'] == 200) {
      print(getdata);
      MyCategoryProvider categoryProvider = Provider.of<MyCategoryProvider>(context, listen: false);
      List<MyCategoryModel> categoryList = (getdata['data'] as List<dynamic>)
          .map((e) => MyCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      categoryProvider.setCategory(categoryList);
    }
  }

  Future getDashboardData(context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    var getdata = await apiBaseHelper.postAPICall(dashboard, {'consumer_id': userId.toString()});
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (getdata['code'] == 200) {
      DashboardModel dashboardModel = DashboardModel.fromJson(getdata['data']);
      HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.setDashboard(dashboardModel);
      homeProvider.changeLoading();
    } else {
      setSnackbar(msg ?? "An Error Occurred", context);
    }
  }

  Future getPredictionData(context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    List<MyCategoryModel> category_list =
        Provider.of<MyCategoryProvider>(context, listen: false).categories;
    print({
      'consumer_id': userId.toString(),
      'category_ids': category_list.map((e) => e.category_id).toList()
    });
    var dio = D.Dio();
    D.Response response = await dio.post('$baseUrl/consumer/user/waste-prediction', data: {
      'consumer_id': userId.toString(),
      'category_ids': category_list.map((e) => e.category_id).toList()
    });
    var getdata = response.data;
    print(getdata);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (getdata['code'] == 200) {

      print(getdata['data']);
      List<PredictionModel> predictionModel = (getdata['data'] as List<dynamic>)
          .map((e) => PredictionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      PredictionProvider predictionProvider=Provider.of<PredictionProvider>(context,listen: false);
      predictionProvider.updatePrediction(predictionModel);
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

  Future getOrderById(context, formId) async {
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    var getdata = await apiBaseHelper.postAPICall(get_order, {
      'consumer_id': userId.toString(),
      'from_id': formId.toString(),
    });
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      List<OrderModel> orderList = (getdata['data'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
      OrderProvider orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.setDustbins(orderList);
      orderProvider.changeIsLoading();
    } else {
      print(msg);
    }
  }

  Future updateConsumerProfile(Map details, context) async {
    var getdata = await apiBaseHelper.postAPICall(update_profile, details);
    Navigator.pop(context);
    bool error = getdata['error'] ?? false;
    if (!error) {
      print('Hello');
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setAddress(details['consumer_address']);
      userProvider.setName(details['consumer_name']);
      print(userProvider.name);
      await settingProvider.setPrefrence('name', details['consumer_name']);
      await settingProvider.setPrefrence('address', details['consumer_address']);
      // settingProvider.saveUserDetail(userProvider.user, context);
    } else {
      print(getdata['msg']);
      setSnackbar(getdata['msg'], context);
    }
  }

  Future getDustbinLocation(context, String pickup_id) async {
    var getdata = await apiBaseHelper.postAPICall(get_dustbin_location, {'pickup_id': pickup_id});
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    if (!error) {
      List<DustbinLocation> dustbinLocation = (getdata['data'] as List<dynamic>)
          .map((e) => DustbinLocation.fromJson(e as Map<String, dynamic>))
          .toList();
      DustbinLocationProvider dustbinLocationProvider =
          Provider.of<DustbinLocationProvider>(context, listen: false);
      dustbinLocationProvider.setDustbinLocation(dustbinLocation);
      dustbinLocationProvider.changeIsLoading();
    } else {
      print(msg);
    }
  }
  Future bookOrder(Map result,context) async {
    print(result);
    var dio = D.Dio();
    D.Response response =
    await dio.post('$baseUrl/consumer/order/book-order', data: result);
    var getdata = response.data;
    Navigator.pop(context);
    bool error = getdata["error"] ?? false;
    String? msg = getdata["message"];
    print(getdata);
    if (getdata['code']==200) {
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    } else {
      print(msg);
    }
  }
}
