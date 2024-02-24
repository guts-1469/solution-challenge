import 'package:flutter/widgets.dart';
import 'package:smart_bin/Splash.dart';
import 'package:smart_bin/screens/activity/activity_screen.dart';
import 'package:smart_bin/screens/dustbin_details/dustbin_details.dart';
import 'package:smart_bin/screens/dustbins/dustbins.dart';
import 'package:smart_bin/screens/food_category.dart';
import 'package:smart_bin/screens/home_page/home_screen.dart';
import 'package:smart_bin/screens/login_page/sing_in_screen.dart';
import 'package:smart_bin/screens/onboarding_screen.dart';
import 'package:smart_bin/screens/otp/otp.dart';
import 'package:smart_bin/screens/profile/profile.dart';
import 'package:smart_bin/screens/signup_page/signup.dart';
import 'package:smart_bin/screens/statistics_page/statistics.dart';
import 'package:smart_bin/screens/wallet.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  Dustbins.routeName: (context) => Dustbins(),
  FoodCategory.routeName: (context) => FoodCategory(),
  HomeScreen.routeName: (context) => HomeScreen(),
  Statistics.routeName: (context) => Statistics(),
  ActivityScreen.routeName: (context) => ActivityScreen(),
  WalletScreen.routeName: (context) => WalletScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
