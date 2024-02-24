import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/models/dustbin_model.dart';
import '../../size_config.dart';
import 'components/body.dart';
class DustbinDetails extends StatelessWidget {
  static String routeName = "/dustbin_details";
  final String id;
  final DustbinModel dustbin;
  const DustbinDetails({Key? key,required this.id,required this.dustbin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: Body(id: id,dustbinDetails:dustbin),)),
    );
  }
}