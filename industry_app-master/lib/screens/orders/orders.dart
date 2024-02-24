import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../size_config.dart';
import 'components/body.dart';
class Orders extends StatelessWidget {
  static String routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: Body(),)),
    );
  }
}