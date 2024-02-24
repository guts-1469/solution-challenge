import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import '../../size_config.dart';
import 'components/body.dart';
class ActivityScreen extends StatelessWidget {
  static String routeName = "/activity_screen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: Body()),
    );
  }
}