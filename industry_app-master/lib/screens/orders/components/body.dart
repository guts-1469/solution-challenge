import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/models/order_model.dart';
import 'package:industry_app/provider/OrderProvider.dart';
import 'package:industry_app/screens/orders/components/order_card.dart';
import 'package:provider/provider.dart';

import '../../../services/sendData.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    SendData().getOrderById(context,0);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        backButton(context),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Orders', style: headingBlack27),
        ),
        Consumer<OrderProvider>(
          builder: (context, provider, child) {
            List<OrderModel>orderList=provider.orders;
            return provider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: List.generate(
                        orderList.length, (index) => OrderCard(order: orderList[index])),
                  );
          },
        )
      ],
    );
  }
}
