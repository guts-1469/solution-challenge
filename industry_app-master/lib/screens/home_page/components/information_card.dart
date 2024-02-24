import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:industry_app/models/dashboard_model.dart';
import 'package:industry_app/screens/activity/activity_screen.dart';
import 'package:industry_app/screens/statistics_page/statistics.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import '../../../widgets/text.dart';
import '../../orders/orders.dart';
import '../../profile/profile.dart';

class InformationCard extends StatefulWidget {
  const InformationCard({Key? key,required this.totalWeight,required this.pickup}) : super(key: key);
  final double totalWeight;
  final List<PickupSchedule> pickup;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  int _currIndex=0;
  Widget circularIconButton(String icon, Function press, String text) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: press as void Function()?,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            primary: Colors.white, // <-- Button color
            onPrimary: Colors.red, // <-- Splash color
          ),
          child: SvgPicture.asset(
            'assets/icons/$icon.svg',
            height: SizeConfig.screenWidth * 0.1,
            color: kPrimaryColor,
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
          style: titleBlack20
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
      height:
        (widget.pickup.length==0)?SizeConfig.screenHeight * 0.32: SizeConfig.screenHeight * 0.42,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Waste Collected',
            style: titleWhite20.copyWith(
                fontWeight: FontWeight.w600, fontSize: getProportionateScreenWidth(20)),
          ),
          defaultSpace,
          Text(
            '${widget.totalWeight.toStringAsPrecision(4)} kg',
            style: headingWhite27,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              circularIconButton('order', () {
                Navigator.pushNamed(context, Orders.routeName);
              }, 'Orders'),
              circularIconButton('activity', () {

                Navigator.pushNamed(context, ActivityScreen.routeName);
              }, 'Activities'),
              circularIconButton('statistics', () {

                Navigator.pushNamed(context, Statistics.routeName);
              }, "Statistics"),
              circularIconButton('person', () {

                Navigator.pushNamed(context, ProfileScreen.routeName);
              }, "Profile"),
            ],
          ),
          const Spacer(),

          if(widget.pickup.length!=0)
          Container(
            padding: EdgeInsets.all(10),
            height: SizeConfig.screenHeight * 0.105,
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
                    itemBuilder: (context,index)=>  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        infoContainer(formatDateMMMd(widget.pickup[index].pickup_date), 'Pickup Date'),
                        infoContainer('${widget.pickup[index].total_weight} kg', 'Weight'),
                        infoContainer("${widget.pickup[index].total_location}", 'Pickup Point'),
                      ],
                    ),
                    itemCount: widget.pickup.length,
                    onPageChanged: (index){
                        setState(() {
                          _currIndex=index;
                        });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.pickup.length, (index) =>_indicator(index==_currIndex)),
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
        height: isActive
            ? 10:8.0,
        width: isActive
            ? 12:8.0,
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
