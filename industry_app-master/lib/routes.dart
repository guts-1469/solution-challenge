import 'package:flutter/widgets.dart';
import 'package:industry_app/screens/activity/activity_screen.dart';
import 'package:industry_app/screens/book_order.dart';
import 'package:industry_app/screens/dustbin_location_screen.dart';
import 'package:industry_app/screens/food_category.dart';
import 'package:industry_app/screens/home_page/home_screen.dart';
import 'package:industry_app/screens/login_page/sing_in_screen.dart';
import 'package:industry_app/screens/onboarding_screen.dart';
import 'package:industry_app/screens/orders/orders.dart';
import 'package:industry_app/screens/profile/profile.dart';
import 'package:industry_app/screens/statistics_page/statistics.dart';

import 'Splash.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  // BookOrder.routeName: (context) => BookOrder(),
  Orders.routeName: (context) => Orders(),
  FoodCategory.routeName: (context) => FoodCategory(),
  HomeScreen.routeName: (context) => HomeScreen(),
  Statistics.routeName: (context) => Statistics(),
  ActivityScreen.routeName: (context) => ActivityScreen(),

  ProfileScreen.routeName: (context) => ProfileScreen(),
};
