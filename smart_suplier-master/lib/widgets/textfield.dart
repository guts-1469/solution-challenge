import 'package:flutter/material.dart';
import '../constant.dart';
import '../size_config.dart';
final InputDecoration inputDecoration=InputDecoration(
    focusedBorder:  const OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor,width: 1.2),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.2),
    ),
    errorBorder:const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.2),
    ),
    border:const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.2),
    ),
    labelStyle: TextStyle(
        fontSize: getProportionateScreenWidth(17),
        fontWeight: FontWeight.w800),
    floatingLabelBehavior: FloatingLabelBehavior.always,
);