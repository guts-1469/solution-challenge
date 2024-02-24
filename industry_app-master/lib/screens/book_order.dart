import 'package:dio/dio.dart' as D;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/models/order_summery.dart';
import 'package:industry_app/models/prediction_model.dart';
import 'package:industry_app/provider/MyCategoryProvider.dart';
import 'package:industry_app/services/sendData.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../provider/CategoryProvider.dart';
import '../provider/UserProvider.dart';
import '../size_config.dart';
import '../widgets/buttons.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text.dart';
import 'orders/components/order_card.dart';

class BookOrder extends StatefulWidget {
  static String routeName = "/book_order";
  PredictionModel predictionModel;

  BookOrder({Key? key, required this.predictionModel}) : super(key: key);

  @override
  State<BookOrder> createState() => _BookOrderState();
}

class _BookOrderState extends State<BookOrder> {
  TextEditingController _timeController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController startTime = TextEditingController();
  num totalCost = 0;
  TextEditingController endTime = TextEditingController();
  List<OrderSummery> orderSummery = [];

  @override
  void initState() {
    // TODO: implement initState
    getOrderSummery();
    super.initState();
  }

  getOrderSummery() async {
    var dio = D.Dio();
    MyCategoryProvider categoryProvider = Provider.of<MyCategoryProvider>(context, listen: false);
    int userId = Provider.of<UserProvider>(context, listen: false).id;
    // print(widget.predictionModel.selected_dustbin_ids);
    D.Response response = await dio.post('$baseUrl/consumer/user/pre-order-summary', data: {
      "consumer_id": userId.toString(),
      "category_ids": categoryProvider.categories.map((e) => e.category_id).toList(),
      "dustbin_ids": widget.predictionModel.selected_dustbin_ids,
      "date": DateFormat('yyyy-MM-dd').format((widget.predictionModel.date)),
    });
    var getdata = response.data;

    // print(getdata);
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
      // print(getdata);
    }
  }

  @override
  Widget build(BuildContext context) {
    String categories = "";
    for (int i = 0; i < widget.predictionModel.selected_categories_name.length; i++) {
      categories += widget.predictionModel.selected_categories_name[i] + ", ";
    }

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
                      'Book Order',
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
                            formatDateMMMd(widget.predictionModel.date),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                          ),
                          defaultSpace2x,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customListTile('Distance', '20 km'),
                              customListTile('Total Weight',
                                  widget.predictionModel.predicted_weight.toStringAsPrecision(2)),
                            ],
                          ),
                          defaultSpace2x,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customListTile('Pickup Points',
                                  widget.predictionModel.selected_dustbin_ids.length.toString()),
                              customListTile('Total Dustbins', widget.predictionModel.selected_dustbin_ids.length.toString()),
                            ],
                          ),
                          defaultSpace2x,
                          customListTile('Categories', categories)
                        ],
                      ),
                    ),
                    defaultSpace3x,
                    Text(
                      'Select Timing',
                      style: titleBoldBlack20,
                    ),
                    defaultSpace2x,
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth * .30,
                            child: TextFormField(
                              controller: startTime,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                hintText: "From",
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty ? "Please Select Time" : null,
                              readOnly: true,
                              onTap: () async {
                                _selectTime(context, startTime);
                              },
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
                              controller: endTime,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                hintText: "To",
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty ? "Please Select Time" : null,
                              readOnly: true,
                              onTap: () async {
                                _selectTime(context, endTime);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    defaultSpace3x,
                    Text(
                      'Order Summary',
                      style: titleBoldBlack20,
                    ),
                    defaultSpace2x,
                    if (orderSummery.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              orderSummery.length,
                              (index) => customRowTile(
                                  orderSummery[index].category_name,
                                  '${orderSummery[index].total_weight} kg',
                                  (index==0)? '${totalCost} Rs': '${orderSummery[index].price_per_unit} Rs'),
                            ),
                            DottedLine(
                              dashColor: kPrimaryColor,
                            ),
                            defaultSpace2x,
                            customRowTile(
                                'Total',
                                widget.predictionModel.predicted_weight.toString(),
                                '$totalCost Rs'),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: DefaultButton(
                      text: 'Book Order',
                      press: () async {
                        int userId = Provider.of<UserProvider>(context, listen: false).id;
                        showLoaderDialog(context);
                        await SendData().bookOrder(
                          {
                            "consumer_id":userId.toString(),
                            "total_distance":20,
                            "total_weight":widget.predictionModel.predicted_weight,
                            "producer_ids":widget.predictionModel.selected_producers,
                            "dustbin_ids":widget.predictionModel.selected_dustbin_ids,
                            "total_cost":totalCost,
                            "categories_name":categories,
                            "time_from":startTime.text,
                            "time_to":endTime.text,
                            "pickup_date": DateFormat('yyyy-MM-dd').format((widget.predictionModel.date))

                        },context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Container(
                      color: Color(0xffD9D9D9),
                      child: Column(
                        children: [
                          Text(
                            'Total Weight',
                            style: titleBlack18,
                          ),
                          Text('${widget.predictionModel.predicted_weight} kg',
                              style: titleBoldBlack20)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectTime(
    BuildContext context,
    controller,
  ) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      // print(pickedTime.format(context));
      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
      // print(parsedTime);
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      // print(formattedTime);
      setState(() {
        controller.text = formattedTime;
      });
    } else {
      // print("Time is not selected");
    }
  }

  customRowTile(String title, String weight, String price) {
    return Column(
      children: [
        Row(
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
        ),
        defaultSpace2x,
      ],
    );
  }
}
