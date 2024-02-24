import 'package:flutter/material.dart';

import 'package:smart_bin/size_config.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  // static String routeName = "/otp";
  final String phone;
  OtpScreen({required this.phone});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      body: SafeArea(child: SingleChildScrollView(child: Body(phone:phone))),
    );
  }
}