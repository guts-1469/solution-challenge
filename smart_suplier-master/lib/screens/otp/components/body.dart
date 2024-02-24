import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_bin/screens/otp/components/countdown_timer.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/widgets/buttons.dart';
import 'package:smart_bin/widgets/text.dart';

import '../../../constant.dart';
import '../../../widgets/loading_dialog.dart';
import 'otp_field.dart';

class Body extends StatefulWidget {
  final String phone;

  Body({Key? key, required this.phone}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _pin = "";

  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        backButton(context),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/otp.svg',
                width: SizeConfig.screenWidth * 0.80,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Verification Code',
                style: headingBlack27,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'We have sent the code verifiation to your mobile',
                textAlign: TextAlign.center,
                style: titleBlack18,
              ),
              const SizedBox(
                height: 25,
              ),
              OtpField(phone: widget.phone, press: (pin) => _pin = pin),
              const SizedBox(
                height: 10,
              ),
              const CountdownTimer(),
              const SizedBox(
                height: 10,
              ),
              DefaultButton(
                text: 'Submit',
                press: () {
                  if (_pin.length != 4) {
                    errorMsg = "Invalid Otp";
                    setState(() {});
                  } else {
                    checkPin(context, _pin);
                  }
                },
              ),
              defaultSpace2x,
              Text(errorMsg, style: titleBlack20.copyWith(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }

  checkPin(BuildContext context, pin) async {
    showLoaderDialog(context);
    var result = await SendData().verifyOtp({
      'phone': widget.phone,
      'otp': pin,
      "token":"testtoken",
    }, context);
    if (result != null) {
      errorMsg = result;
      setState(() {});
    }
  }
}
