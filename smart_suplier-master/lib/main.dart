import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_bin/Splash.dart';
import 'package:smart_bin/provider/ActivityProvider.dart';
import 'package:smart_bin/provider/DustbinDetailsProvider.dart';
import 'package:smart_bin/provider/DustbinProvider.dart';
import 'package:smart_bin/provider/HomeProvider.dart';
import 'package:smart_bin/provider/StatisticsProvider.dart';
import 'package:smart_bin/provider/TransactionProvider.dart';
import 'package:smart_bin/provider/UserProvider.dart';
import 'package:smart_bin/routes.dart';
import 'package:smart_bin/screens/activity/activity_screen.dart';
import 'package:smart_bin/screens/food_category.dart';
import 'package:smart_bin/screens/wallet.dart';
import 'package:smart_bin/services/save_preference.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  SharedPreferences prefs = await SharedPreferences.getInstance();
    return runApp(MyApp(sharedPreferences: prefs,));
}

class MyApp extends StatelessWidget {
  late SharedPreferences sharedPreferences;

  MyApp({Key? key,required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<SettingProvider>(
          create: (context) => SettingProvider(sharedPreferences),
        ),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),

        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),

        ChangeNotifierProvider<TransactionProvider>(
            create: (context) => TransactionProvider()),

        ChangeNotifierProvider<StatisticsProvider>(
            create: (context) => StatisticsProvider()),

        ChangeNotifierProvider<ActivityProvider>(
            create: (context) => ActivityProvider()),

        ChangeNotifierProvider<DustbinProvider>(
            create: (context) => DustbinProvider()),

        ChangeNotifierProvider<DustbinDetailsProvider>(
            create: (context) => DustbinDetailsProvider()),
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
