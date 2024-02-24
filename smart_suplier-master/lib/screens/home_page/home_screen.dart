import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import '../../size_config.dart';
import 'components/body.dart';
class HomeScreen extends StatelessWidget {
  static String routeName = "/home_screen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: Body(),)),
    );
  }
}