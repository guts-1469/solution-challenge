import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:industry_app/provider/UserProvider.dart';
import 'package:industry_app/screens/food_category.dart';
import 'package:industry_app/screens/home_page/home_screen.dart';
import 'package:industry_app/screens/login_page/sing_in_screen.dart';
import 'package:industry_app/screens/onboarding_screen.dart';
import 'package:industry_app/services/save_preference.dart';
import 'package:industry_app/services/sendData.dart';
import 'package:industry_app/size_config.dart';
import 'package:industry_app/widgets/text.dart';
import 'package:provider/provider.dart';

import 'constant.dart';

//splash screen of app
class Splash extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: double.infinity,
            //decoration: back(),
            child: Center(
              child: Text(
                "Smart Industry",
                style: headingWhite27,
              ),
            ),
          ),
        ],
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    SettingProvider settingsProvider = Provider.of<SettingProvider>(this.context, listen: false);

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isFirstTime = await settingsProvider.getPrefrenceBool("firstTime");
    print(isFirstTime);
    bool isCategory = await settingsProvider.getPrefrenceBool("isCategory");
    int? id = settingsProvider.userId;
    if (id != null) {
      String name = settingsProvider.userName;
      String phone = settingsProvider.phone;
      String address = settingsProvider.address;
      userProvider.setPhone(phone);
      userProvider.setAddress(address);
      userProvider.setId(id);
      userProvider.setName(name);

      if (isCategory) {

        await SendData().getUserCategories(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, FoodCategory.routeName);
      }
    } else if (!isFirstTime) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => SignInScreen(),
          ));
    } else {

      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => OnboardingScreen(),
          ));
    }
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
    ));
  }

  @override
  void dispose() {
    //  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
