import 'package:flutter/material.dart';

import '../constant.dart';
import '../size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  RoundedIconBtn({
    Key? key,
    required this.text,
    this.color = kPrimaryColor,
    required this.icon,
    required this.press,
    this.borderRadius = 0,
    this.width,
    this.height,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  Text text;
  Color color;
  double borderRadius;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(height ?? 50),
      width: getProportionateScreenWidth(width ?? double.infinity),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: press,
        icon: Icon(icon,color: Colors.white,),
        label: text,
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(50),
      child: TextButton(
        onPressed: press as void Function()?,
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          primary: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: getProportionateScreenWidth(17), color: Colors.white),
        ),
      ),
    );
  }
}

Widget backButton(context) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: kPrimaryColor,
          size: 35,
        )),
  );
}

class CustomButton extends StatelessWidget {
  Text text;
  Color color;
  IconData? icon;
  double borderRadius;
  Function press;
  double? height;
  double? width;

  CustomButton(
      {required this.text,
      this.color = kPrimaryColor,
      this.icon,
      required this.press,
      this.borderRadius = 0,
      this.width,
      this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: press as void Function()?,
        child: text,
        style: TextButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
        ),
      ),
    );
  }
}
