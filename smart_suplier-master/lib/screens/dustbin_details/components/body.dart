import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/models/dustbin_model.dart';
import 'package:smart_bin/provider/DustbinDetailsProvider.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/widgets/buttons.dart';

import '../../../models/dustbin_details_model.dart';
import '../../../services/sendData.dart';
import '../../../widgets/text.dart';
import 'stat_charts.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.id,required this.dustbinDetails}) : super(key: key);
  final DustbinModel dustbinDetails;
  final String id;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SendData().fetchDustbinDetails(widget.id.toString(), context);
  }

  Widget statsContainer(String value, String text) {
    return Container(
      margin: EdgeInsets.all(5),
      width: SizeConfig.screenWidth * 0.28,
      height: SizeConfig.screenWidth * .26,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: violetColor,
      ),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          defaultSpace,
          Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(13),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double currentCapacity=100-(widget.dustbinDetails.current_capacity/widget.dustbinDetails.total_capacity)*100;
    return Consumer<DustbinDetailsProvider>(
      builder: (context, provider, child) {
        DustbinDetailsModel dustbinDetailsModel = provider.getDetailsModel;
        return provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButton(context),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dustbin #${widget.id}',
                          style: headingBlack27,
                        ),
                        defaultSpace3x,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statsContainer('${dustbinDetailsModel.daily_average_weight.toStringAsPrecision(4)} kg',
                                'Average Food Waste'),
                            statsContainer('${dustbinDetailsModel.highest_daily_weight.toStringAsPrecision(4)} kg',
                                'Highest Waste in a day'),
                            statsContainer(
                                '${dustbinDetailsModel.last_week_waste.toStringAsPrecision(4)} kg', 'Last Week Waste'),
                          ],
                        ),
                        defaultSpace3x,
                        pieChart(dustbinDetailsModel,currentCapacity),
                        defaultSpace3x,
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: customListTile(
                                        'Dustbin Name', dustbinDetailsModel.dustbin.dustbin_name),
                                  ),
                                  customListTile('Created At',
                                      formatDateMMMd(dustbinDetailsModel.dustbin.created_at)),
                                ],
                              ),
                              defaultSpace3x,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customListTile('Current Waste',
                                      '${dustbinDetailsModel.dustbin.total_capacity.toStringAsPrecision(4)} kg'),
                                  customListTile(
                                      'Cateogry', dustbinDetailsModel.dustbin.category_name),
                                ],
                              ),
                              defaultSpace3x,
                              CustomButton(
                                text: Text(
                                  'Change Category',
                                  style: titleWhite20,
                                ),
                                press: () {},
                                width: double.infinity,
                                color: violetColor,
                              ),
                            ],
                          ),
                        ),
                        defaultSpace3x,
                        StatsChart(
                          distribution: dustbinDetailsModel.distribution,
                        )
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }

  Widget customListTile(String heading, String subheading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            heading,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.bold,
                color: Color(0xff89898A),
            overflow: TextOverflow.clip),
          ),
        ),
        defaultSpace,
        Text(
          subheading,
          style: titleBlack20.copyWith(color: violetColor),
        ),
      ],
    );
  }

  Widget pieChart(DustbinDetailsModel dustbinDetailsModel,double currentCapcity) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          dataMap: {'a':double.parse((80-currentCapcity*0.80).toStringAsPrecision(4)) , 'b': double.parse((currentCapcity*0.80).toStringAsPrecision(4)), 'c': 20},
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 12,
          chartRadius: MediaQuery.of(context).size.width / 1.5,
          colorList: [Colors.blue, Color(0xffD5D8FD), Colors.transparent],
          ringStrokeWidth: 15,
          initialAngleInDegree: 124,
          chartType: ChartType.ring,
          legendOptions: const LegendOptions(
            showLegends: false,
          ),
          chartValuesOptions: const ChartValuesOptions(showChartValues: false),
        ),
        PieChart(
          dataMap: {'a':double.parse((80-currentCapcity*0.80).toStringAsPrecision(4)) , 'b': double.parse((currentCapcity*0.80).toStringAsPrecision(4)), 'c': 20},
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 12,
          chartRadius: MediaQuery.of(context).size.width / 1.5,
          colorList: [violetColor, Colors.transparent, Colors.transparent],
          ringStrokeWidth: 25,
          initialAngleInDegree: 124,
          chartType: ChartType.ring,
          legendOptions: const LegendOptions(
            showLegends: false,
          ),
          chartValuesOptions: const ChartValuesOptions(showChartValues: false),
        ),
        Column(
          children: [
            Text('Capacity Left'),
            Text(
              '${(100-currentCapcity).toStringAsPrecision(4)}% Full',
              style: headingBlack27.copyWith(color: violetColor),
            ),
            Text(
              '3 Times Empty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: violetColor),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          child: Text(
            '${(widget.dustbinDetails.current_capacity).toStringAsPrecision(3)} kg Waste',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: violetColor),
          ),
        )
      ],
    );
  }
}
