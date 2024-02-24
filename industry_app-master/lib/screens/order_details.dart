import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/models/order_model.dart';
import 'package:industry_app/screens/dustbin_location_screen.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/order_summery.dart';
import '../provider/CategoryProvider.dart';
import '../provider/UserProvider.dart';
import '../size_config.dart';
import '../widgets/buttons.dart';
import '../widgets/text.dart';
import 'orders/components/order_card.dart';
import 'package:dio/dio.dart' as D;
class OrderDetails extends StatefulWidget {
  OrderDetails({Key? key, required this.orderModel}) : super(key: key);
  OrderModel orderModel;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  num totalCost = 0;
  TextEditingController endTime = TextEditingController();
  List<OrderSummery> orderSummery = [];

  getOrderSummery() async {
    var dio = D.Dio();
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    int userId = Provider.of<UserProvider>(context, listen: false).id;

    D.Response response = await dio.post('$baseUrl/consumer/user/pre-order-summary', data: {
      "consumer_id": userId.toString(),
      "category_ids": categoryProvider.categories.map((e) => e.id).toList(),
      // "dustbin_ids": widget.orderModel.,
      "date":widget.orderModel.pickup_date,
    });
    var getdata = response.data;

    print(getdata);
    bool error = getdata['error'] ?? false;
    if (getdata['code'] == 200) {
      List<OrderSummery> _orderSummery = (getdata['data'] as List<dynamic>)
          .map((e) => OrderSummery.fromJson(e as Map<String, dynamic>))
          .toList();
      orderSummery = _orderSummery;
      for (int i = 0; i < orderSummery.length; i++) {
        totalCost += double.parse(orderSummery[i].price_per_unit) * (orderSummery[i].total_weight);
      }
      setState(() {});
    } else {
      print(getdata);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        // bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButton(context),
                    Text(
                      'Order #${widget.orderModel.id}',
                      style: headingBlack27,
                    ),
                    defaultSpace3x,
                    Text(
                      'Order Details',
                      style: titleBoldBlack20,
                    ),
                    defaultSpace2x,
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatDateMMMd(widget.orderModel.pickup_date),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                          ),
                          defaultSpace2x,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customListTile('Distance', '${widget.orderModel.total_distance} km'),
                              customListTile(
                                  'Total Weight', '${widget.orderModel.total_distance} kg'),
                            ],
                          ),
                          defaultSpace2x,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customListTile(
                                  'Pickup Points', widget.orderModel.total_location.toString()),
                              customListTile(
                                  'Total Dustbins', widget.orderModel.total_dustbin.toString()),
                            ],
                          ),
                          defaultSpace2x,
                          customListTile('Categories', widget.orderModel.categories_name)
                        ],
                      ),
                    ),
                    defaultSpace3x,
                    Text(
                      'Timing',
                      style: titleBoldBlack20,
                    ),
                    defaultSpace2x,
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * .30,
                          child: TextFormField(
                            initialValue: widget.orderModel.time_from,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              border: InputBorder.none,
                              hintText: "From",
                            ),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '-',
                          style: titleBoldBlack20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * .30,
                          child: TextFormField(
                            initialValue: widget.orderModel.time_to,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              border: InputBorder.none,
                            ),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    defaultSpace3x,
                    Text(
                      'Order Summary',
                      style: titleBoldBlack20,
                    ),
                    defaultSpace2x,
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customRowTile('Category A', '20 kg', '20 Rs'),
                          defaultSpace2x,
                          customRowTile('Category A', '20 kg', '20 Rs'),
                          defaultSpace2x,
                          customRowTile('Category A', '20 kg', '20 Rs'),
                          defaultSpace2x,
                          DottedLine(
                            dashColor: kPrimaryColor,
                          ),
                          defaultSpace2x,
                          customRowTile('Total', '${widget.orderModel.total_weight}',
                              'Rs ${widget.orderModel.total_cost}'),
                        ],
                      ),
                    ),
                    defaultSpace3x,
                    if (widget.orderModel.pickup_status == 1)
                      DefaultButton(
                        text: 'View Dustbin Location',
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DustbinLocationScreen(
                                        pickup_id: widget.orderModel.id.toString(),
                                      )));
                        },
                      ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  customRowTile(String title, String weight, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleBlack18,
        ),
        Row(
          children: [
            Text(
              weight,
              style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              price,
              style: titleBlack18,
            ),
          ],
        )
      ],
    );
  }
}
