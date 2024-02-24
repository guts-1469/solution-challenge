import 'package:flutter/material.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/widgets/text.dart';

import '../constant.dart';

class Charts extends StatelessWidget {
  const Charts(
      {required this.xScale,
      required this.yScale,
      required this.title,
      required this.child,
      Key? key})
      : super(key: key);
  final String xScale, yScale, title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: titleBlack20,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'X-axis : $xScale     Y-Axis: $yScale',
                style: titleBlack18.copyWith(color: kPrimaryColor),
              )),
          defaultSpace3x,
          Container(
              padding: EdgeInsets.only(right: getProportionateScreenWidth(15)),
              height: SizeConfig.screenHeight * 0.35,
              child: child),
        ],
      ),
    );
  }
}
