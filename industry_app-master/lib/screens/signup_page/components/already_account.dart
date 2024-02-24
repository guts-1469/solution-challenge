import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import '../../login_page/sing_in_screen.dart';
class AlreadyAccount extends StatelessWidget {
  const AlreadyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
          child: Text(
            "Sign In",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
