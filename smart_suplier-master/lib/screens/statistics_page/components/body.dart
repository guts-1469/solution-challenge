import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/models/statistics_model.dart';
import 'package:smart_bin/provider/StatisticsProvider.dart';
import 'package:smart_bin/screens/statistics_page/components/stat_charts.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/widgets/buttons.dart';

import '../../../provider/UserProvider.dart';
import '../../../widgets/text.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userId = Provider.of<UserProvider>(context, listen: false).id.toString();
    SendData().fetchStatistics({'producer_id':userId}, context);
  }
  Widget statsContainer(String value, String text) {
    return Container(
      margin: EdgeInsets.all(5),
      width: SizeConfig.screenWidth * 0.28,
      height: SizeConfig.screenWidth * .26,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kPrimaryColor,
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
    return Consumer<StatisticsProvider>(

      builder: (context, provider, child) {
        StatisticsModel statisticsModel = provider.getStatistics;
        return provider.isLoading?Container(

            child: Center(child: CircularProgressIndicator())):SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              backButton(context),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistics',
                      style: headingBlack27,
                    ),
                    defaultSpace3x,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statsContainer(
                            '${statisticsModel.daily_average_weigh.toStringAsFixed(2)} kg', 'Average Food Waste'),
                        statsContainer(
                            '${statisticsModel.highest_daily_waste.toStringAsPrecision(4)} kg', 'Highest Waste in a day'),
                        statsContainer('${statisticsModel.last_week_waste.toStringAsPrecision(4)} kg', 'Last Week Waste'),
                      ],
                    ),
                    defaultSpace3x,
                    StatsChart(
                      recoveryDistribution: statisticsModel.recovery_distribution,
                      averageWaste: statisticsModel.average_waste,
                      wasteDistribution: statisticsModel.waste_distribution,
                    )
                  ],
                ),
              ),
          ],
        ),
            );
      },
    );
  }
}
