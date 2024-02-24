import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../size_config.dart';
import 'components/body.dart';
class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile_screen";

  ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: Body(),)),
    );
  }
}