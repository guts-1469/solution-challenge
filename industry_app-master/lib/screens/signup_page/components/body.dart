import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import '../../../widgets/text.dart';
import 'signup_form.dart';

class Body extends StatelessWidget {
  final String phoneNo;
  const Body({Key? key,required this.phoneNo}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: SvgPicture.asset('assets/images/register.svg',height: 250,)),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Text(
            "Welcome !",
            style: titleBlack18,
          ),
          Text("Register", style: headingBlack27),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          SignUpForm(phoneNo: phoneNo,),

          // const AlreadyAccount(),
        ],
      ),
    );
  }
}
