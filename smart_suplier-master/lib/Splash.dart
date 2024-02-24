import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/provider/UserProvider.dart';
import 'package:smart_bin/screens/food_category.dart';
import 'package:smart_bin/screens/home_page/home_screen.dart';
import 'package:smart_bin/screens/login_page/sing_in_screen.dart';
import 'package:smart_bin/screens/onboarding_screen.dart';
import 'package:smart_bin/services/save_preference.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/widgets/text.dart';
//splash screen of app
class Splash extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {
  @override
  void initState() {
    log('sd0');
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
                "Waste Bridge",
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
    bool isCategory = await settingsProvider.getPrefrenceBool('isCategory');
    int? id = settingsProvider.userId;
    if (id != null) {
      String name = settingsProvider.userName;
      String phone = settingsProvider.phone;
      String address = settingsProvider.address;
      int walletBalance = settingsProvider.walletBalance;
      int greenBalance = settingsProvider.greenBalance;
      userProvider.setPhone(phone);
      userProvider.setWalletBalance(walletBalance);
      userProvider.setGreenBalance(greenBalance);
      userProvider.setAddress(address);
      userProvider.setId(id);
      userProvider.setName(name);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
       } else if (!isFirstTime) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => SignInScreen(),
          ));
    }
    else {
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
