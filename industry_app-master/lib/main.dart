import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:industry_app/Splash.dart';
import 'package:industry_app/provider/ActivityProvider.dart';
import 'package:industry_app/provider/CategoryProvider.dart';
import 'package:industry_app/provider/DustbinLocationProvider.dart';
import 'package:industry_app/provider/HomeProvider.dart';
import 'package:industry_app/provider/MyCategoryProvider.dart';
import 'package:industry_app/provider/OrderProvider.dart';
import 'package:industry_app/provider/PredictionProvider.dart';
import 'package:industry_app/provider/StatisticsProvider.dart';
import 'package:industry_app/provider/UserProvider.dart';
import 'package:industry_app/routes.dart';
import 'package:industry_app/screens/book_order.dart';
import 'package:industry_app/screens/dustbin_location_screen.dart';
import 'package:industry_app/screens/orders/orders.dart';
import 'package:industry_app/screens/statistics_page/statistics.dart';
import 'package:industry_app/services/save_preference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  late SharedPreferences sharedPreferences;

  MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SettingProvider>(
          create: (context) => SettingProvider(sharedPreferences),
        ),
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
        ChangeNotifierProvider<StatisticsProvider>(create: (context) => StatisticsProvider()),
        ChangeNotifierProvider<ActivityProvider>(create: (context) => ActivityProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (context) => OrderProvider()),

        ChangeNotifierProvider<PredictionProvider>(create: (context) => PredictionProvider()),
        ChangeNotifierProvider<MyCategoryProvider>(create: (context) => MyCategoryProvider()),
        ChangeNotifierProvider<CategoryProvider>(create: (context) => CategoryProvider()),
        ChangeNotifierProvider<DustbinLocationProvider>(create: (context) => DustbinLocationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primarySwatch: Colors.green,
          primaryColor: Color(0xFF00706B),
        ),
        initialRoute: Splash.routeName,
        routes: routes,
      ),
    );
  }
}
