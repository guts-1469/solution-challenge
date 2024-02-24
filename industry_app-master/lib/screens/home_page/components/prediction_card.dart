import 'package:flutter/material.dart';
import 'package:industry_app/constant.dart';
import 'package:industry_app/models/prediction_model.dart';
import 'package:industry_app/provider/PredictionProvider.dart';
import 'package:industry_app/screens/book_order.dart';
import 'package:industry_app/services/sendData.dart';
import 'package:industry_app/size_config.dart';
import 'package:provider/provider.dart';

import '../../../widgets/text.dart';

class PredictionCard extends StatefulWidget {
  const PredictionCard({Key? key}) : super(key: key);

  @override
  State<PredictionCard> createState() => _PredictionCardState();
}

class _PredictionCardState extends State<PredictionCard> {
  @override
  void initState() {
    SendData().getPredictionData(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PredictionProvider>(builder: (context, provider, child) {
      final List<PredictionModel> prediction = provider.preditiction;

      return (provider.predictionLoading)
          ? Container()
          : Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Book Food Waste',
                          style: titleBlack20,
                        ),
                        Text(
                          '(Approx Waste)',
                          style: titleBlack20.copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    defaultSpace3x,
                    prediction.isEmpty
                        ? Text('No Data Available')
                        : Center(
                          child: Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              crossAxisAlignment: WrapCrossAlignment.center,

                              children: List.generate(
                                  prediction.length,
                                  (index) => buildCard(formatDateMMd(prediction[index].date),
                                          prediction[index].predicted_weight.toStringAsPrecision(4), () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                BookOrder(predictionModel: prediction[index])));
                                      })),
                            ),
                        ),
                  ],
                ),
              ),
            );
    });
  }

  buildCard(String date, String amount, VoidCallback press) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(24),
                  color: kPrimaryColor),
            ),
            Text(
              date,
              style: titleBlack18,
            ),
            if(double.parse(amount)==0)
                Text('Booked',style: TextStyle(color: kRedColor),)

          ],
        ),
      ),
    );
  }
}
