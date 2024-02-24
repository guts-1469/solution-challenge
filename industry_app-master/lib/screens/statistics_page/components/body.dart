import 'package:flutter/material.dart';
import 'package:industry_app/screens/statistics_page/components/stat_charts.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../models/statistics_model.dart';
import '../../../provider/StatisticsProvider.dart';
import '../../../provider/UserProvider.dart';
import '../../../services/sendData.dart';
import '../../../size_config.dart';
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
    // TODO: implement initState
    super.initState();
    String userId = Provider.of<UserProvider>(context, listen: false).id.toString();
    SendData().fetchStatistics({'consumer_id': userId}, context);
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
        print(statisticsModel.toJson());
        DustbinPickUp dustbinPickUp = statisticsModel.total_dustbin_pickups;
        return provider.isLoading
            ? CircularProgressIndicator()
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
                          'Statistics',
                          style: headingBlack27,
                        ),
                        defaultSpace3x,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statsContainer(
                                '${dustbinPickUp.total_weight} kg', 'Total Wasted Collected'),
                            statsContainer(
                                'Rs ${dustbinPickUp.total_cost}', 'Total Cost for Waste'),
                            statsContainer(
                                '${dustbinPickUp.total_distance} km', 'Total Distance Travelled'),
                          ],
                        ),
                        defaultSpace3x,
                        StatsChart(
                          categoryDistribution: statisticsModel.category_distribution,
                          dayCostDistribution: statisticsModel.day_cost_distribution,
                          distanceDistribution: statisticsModel.distance_distribution,
                          foodWasteDistribution: statisticsModel.food_waste_distribution,
                        )
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
