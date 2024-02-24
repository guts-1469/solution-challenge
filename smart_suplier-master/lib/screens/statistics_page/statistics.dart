import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import '../../size_config.dart';
import 'components/body.dart';
class Statistics extends StatelessWidget {
  static String routeName = "/statistics";

  const Statistics({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: Body()),
    );
  }
}