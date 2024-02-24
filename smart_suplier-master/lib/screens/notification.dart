import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_bin/constant.dart';
import '../../size_config.dart';
import '../widgets/buttons.dart';
import '../widgets/text.dart';
class Notification extends StatelessWidget {
  static String routeName = "/notification";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child:
      Column(
        children: [
          backButton(context),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification',
                  style: headingBlack27,
                ),
                defaultSpace2x,
                ListTile(
                  horizontalTitleGap: 0,
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                      radius: getProportionateScreenWidth(40),
                      child: SvgPicture.asset(
                        'assets/icons/battery_low.svg',
                        color: Colors.white,
                        width: getProportionateScreenWidth(30),
                      ),
                      backgroundColor: kRedColor),
                  title: Text(
                    'Dustbin 2 has low battery',
                    style: titleBlack20.copyWith(color: kRedColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Thu 4 Aug 2022 at 9:30am'),
                ),
                defaultSpace2x,
                ListTile(
                  horizontalTitleGap: 0,
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                      radius: getProportionateScreenWidth(40),
                      child: SvgPicture.asset(
                        'assets/icons/trash.svg',
                        color: Colors.white,
                        width: getProportionateScreenWidth(30),
                      ),
                      backgroundColor: kGreenColor),
                  title: Text(
                    'Bin has been emptied',
                    style: titleBlack20.copyWith(color: kGreenColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Thu 4 Aug 2022 at 9:30am'),
                ),

                defaultSpace2x,
                ListTile(
                  horizontalTitleGap: 0,
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                      radius: getProportionateScreenWidth(40),
                      child: SvgPicture.asset(
                        'assets/icons/cloud.svg',
                        color: Colors.white,
                        width: getProportionateScreenWidth(30),
                      ),
                      backgroundColor: kYellowColor),
                  title: Text('Dustbin 3 is offline',
                    style: titleBlack20.copyWith(color: kYellowColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Thu 4 Aug 2022 at 9:30am'),
                ),
              ],
            ),
          )
        ],
      ),)),
    );
  }
}