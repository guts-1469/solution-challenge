import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/models/order_model.dart';
import 'package:industry_app/screens/order_details.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import '../../../widgets/text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDateMMMd(order.pickup_date),
                  style: titleWhite18.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w800),
                ),
                Container(
                  color: order.pickup_status == 0 ? kPrimaryColor : Color(0xff02BAA8),
                  padding: EdgeInsets.all(5),
                  child: Text(order.pickup_status  == 0 ? "Upcoming" : "Picked",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            defaultSpace2x,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customListTile('Distance', '${order.total_distance} km'),
                customListTile('Location', order.total_location.toString())
              ],
            ),
            defaultSpace2x,
            DottedLine(),
            defaultSpace2x,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customListTile('Total Weight', '${order.total_weight} kg'),
                customListTile('Total Cost', 'Rs ${order.total_cost}')
              ],
            ),
            defaultSpace2x,
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetails(orderModel: order,)));
                },
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  primary: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      "View More Details",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(17), color: Colors.white),
                    ),
                    Icon(CupertinoIcons.right_chevron),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
Widget customListTile(String heading, String subheading) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        heading,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            fontWeight: FontWeight.bold,
            color: Color(0xff89898A)),
      ),
      defaultSpace,
      Text(
        subheading,
        style: titleBlack18.copyWith(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
