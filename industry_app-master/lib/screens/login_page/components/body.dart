import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:industry_app/constant.dart';
import 'package:industry_app/widgets/buttons.dart';
import 'package:industry_app/widgets/text.dart';
import 'package:industry_app/widgets/textfield.dart';

import '../../../services/sendData.dart';
import '../../../size_config.dart';
import '../../../utils/keyboard.dart';
import '../../../widgets/loading_dialog.dart';
import '../../otp/otp.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();

  String? phoneNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/login.svg',width: SizeConfig.screenWidth,),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Text(
              "Welcome Back !",
              style: titleBlack18,
            ),
            Text("Sign in with Phone no", style: headingBlack27),
            Text(
              "Sign in to access your account",
              style: titleBlack18,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.07,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              onSaved: (newValue) => phoneNo = newValue,
              decoration: inputDecoration.copyWith(labelText: "Phone No"),
              validator: (value) {
                if (value!.isEmpty) {
                  return kPhoneNumberNullError;
                } else if (value.length != 10) {
                  return kInvalidPhoneError;
                }
                return null;
              },
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.06,
            ),
            DefaultButton(
                text: "Sign Up",
                press: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    setState(() {});
                    showLoaderDialog(context);
                    var result = await SendData().sendOtp(phoneNo!,context);

                  }
                }),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
