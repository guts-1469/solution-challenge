import 'package:flutter/material.dart';
import 'package:industry_app/screens/login_page/components/body.dart';

import '../../size_config.dart';
class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(child: Body())
      ),
    );
  }
}
