import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../models/user_model.dart';
import '../../../size_config.dart';

class OtpField extends StatelessWidget {
  final String phone;
  Function(String) press;
  OtpField({Key? key, required this.phone,required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
            fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(234, 239, 243, 1),
        ),
        margin: EdgeInsets.all(SizeConfig.screenWidth * 0.005));

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: kPrimaryColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
      ),
    );

    return Pinput(
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        // validator: (s) {
        //   return s ? null : 'Pin is incorrect';
        // },
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        pinAnimationType: PinAnimationType.slide,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        length: 4,
        onCompleted:press

    );
  }

}
