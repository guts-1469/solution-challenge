import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import '../../size_config.dart';
import 'components/body.dart';
class Dustbins extends StatelessWidget {
  static String routeName = "/dustbins";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: Body(),)),
    );
  }
}