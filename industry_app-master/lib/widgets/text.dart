import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class HeadingWidget extends StatelessWidget {
  final String text;
  final Color? color;

  const HeadingWidget({required this.text, this.color = Colors.white, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 28),
      textAlign: TextAlign.center,
    );
  }
}

final TextStyle headingBlack27 =
    GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: getProportionateScreenWidth(30));
final TextStyle titleBlack18 =
    TextStyle(fontWeight: FontWeight.w500, fontSize: getProportionateScreenWidth(15));
final TextStyle titleBlack20 =
    TextStyle(fontWeight: FontWeight.w500, fontSize: getProportionateScreenWidth(18));

final TextStyle titleBoldBlack20 =
TextStyle(fontWeight: FontWeight.w600, fontSize: getProportionateScreenWidth(18));
final TextStyle headingWhite27 =
GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: getProportionateScreenWidth(30),color: Colors.white);
final TextStyle titleWhite18 =
TextStyle(fontWeight: FontWeight.w500, fontSize: getProportionateScreenWidth(15),color: Colors.white);
final TextStyle titleWhite20 =
TextStyle(fontWeight: FontWeight.w500, fontSize: getProportionateScreenWidth(18),color: Colors.white);
