import 'package:flutter/material.dart';
import 'package:industry_app/size_config.dart';
import 'package:intl/intl.dart';

const String baseUrl = 'http://45.130.229.176:3000';

final int timeOut = 50;
const int perPage = 10;
Map days={
  'Mon':0,
  'Tue':1,
  'Wed':2,
  'Thu':3,
  'Fri':4,
  'Sat':5,
  'Sun':6
};
setSnackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    elevation: 1.0,
  ));
}
const kPrimaryColor = Color(0xFF0F7AE1);
const kPrimaryLightColor = Color(0xFFFFCF30);
const kRedColor=Color(0xffC7273A);
const kGreenColor=Color(0xff02BAA8);
const kYellowColor=Color(0xffF4A640);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF00706B), Color(0xFFFFCF30)],
);
const kSecondaryColor = Color(0xFFFFCF30);
const kTextColor = Color(0xFF757575);
//colors
const lineCharColor = [
  Color(0xffE31A1C),
  Color(0xff1F78B4),
  Color(0xff33A02C),
  Color(0xff6a3d9a),
  Color(0xffff7f00),
  Color(0xfffb9a99),
  Color(0xff120be3),
];
const barChartColor = [
  Color(0xff02BAA8),
  Color(0xffE31A1C),
  Color(0xff1F78B4),
  Color(0xff6a3d9a),
  Color(0xffff7f00),
  Color(0xfffb9a99),
  Color(0xff120be3),
];
//duration
const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);
//Form Error
const String kInvalidPhoneError = "Please Enter Valid Phone No";
const String kOtpNullError = "Please Enter your OTP";
const String kMatchOtpError = "Wrong Otp";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
final defaultHeight = SizeConfig.screenHeight * 0.008;
const backgroundColor = Color(0xffF1F3F7);
//spacing
final defaultSpace = SizedBox(height: SizeConfig.screenHeight * 0.008);
final defaultSpace2x = SizedBox(height: SizeConfig.screenHeight * 0.02);
final defaultSpace3x = SizedBox(height: SizeConfig.screenHeight * 0.03);

String formatDateMMMd(DateTime date)=>DateFormat.yMMMd().format(date);

String formatDateMMd(DateTime date)=>DateFormat.MMMd().format(date);
String formatTime(DateTime date )=> DateFormat.jm().format(date);