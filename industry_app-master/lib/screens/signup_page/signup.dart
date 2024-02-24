import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/body.dart';
class SignUpScreen extends StatelessWidget {
  final String phoneNo;
  const SignUpScreen({Key? key,required this.phoneNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
        body: SafeArea(child: SingleChildScrollView(child: Body(phoneNo: phoneNo,)))
    );
  }
}
