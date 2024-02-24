import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_bin/models/dustbin_model.dart';
import 'package:smart_bin/screens/dustbins/dustbins.dart';
import 'package:smart_bin/screens/statistics_page/statistics.dart';

import '../../../constant.dart';
import '../../../models/dashboard_model.dart';
import '../../../size_config.dart';
import '../../../widgets/text.dart';
import '../../activity/activity_screen.dart';

class InformationCard extends StatefulWidget {
  const InformationCard({Key? key, required this.dustbinData, required this.totalWaste})
      : super(key: key);
  final List<DustbinData> dustbinData;
  final String totalWaste;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  int _currIndex = 0;

  Widget circularIconButton(String icon, Function press, String text) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: press as void Function()?,
          child: SvgPicture.asset(
            'assets/icons/$icon.svg',
            height: SizeConfig.screenWidth * 0.1,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            primary: Colors.white, // <-- Button color
            onPrimary: Colors.red, // <-- Splash color
          ),
        ),
        defaultSpace,
        Text(
          text,
          style: titleWhite18,
        ),
      ],
    );
  }

  Widget infoContainer(String value, String desc) {
    return Column(
      children: [
        Text(
          value,
          style: titleBlack18.copyWith(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        Text(
          desc,
          style: titleBlack18,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: SizeConfig.screenHeight * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Waste',
            style: titleWhite20.copyWith(
                fontWeight: FontWeight.w600, fontSize: getProportionateScreenWidth(20)),
          ),
          defaultSpace,
          Text(
            '${(double.parse(widget.totalWaste)).toStringAsPrecision(4)} kg',
            style: headingWhite27,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              circularIconButton('dustbin', () {
                Navigator.pushNamed(context, Dustbins.routeName);
              }, 'View Dustbin'),
              circularIconButton('activity', () {
                Navigator.pushNamed(context, ActivityScreen.routeName);

              }, 'Activities'),
              circularIconButton('statistics', () {
                Navigator.pushNamed(context, Statistics.routeName);
              }, "Statistics")
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.all(10),
            height: SizeConfig.screenHeight * 0.14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: PageView.builder(
                    itemBuilder: (context, index) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            infoContainer(widget.dustbinData[index].total_capacity.toStringAsPrecision(4) , 'Capacity'),
                            infoContainer(widget.dustbinData[index].total_weight.toStringAsPrecision(4), 'Weight'),
                            infoContainer("26 Aug", 'Full Until'),
                          ],
                        ),
                        defaultSpace,
                        Text(
                          widget.dustbinData[index].dustbin_name,
                          style: titleBlack18.copyWith(color: kPrimaryColor),
                        )
                      ],
                    ),
                    itemCount: widget.dustbinData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currIndex = index;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.dustbinData.length, (index) => _indicator(index == _currIndex)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 6 : 4.0,
        width: isActive ? 6 : 4.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
