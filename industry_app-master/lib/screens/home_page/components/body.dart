import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:industry_app/constant.dart';
import 'package:industry_app/models/dashboard_model.dart';
import 'package:industry_app/provider/HomeProvider.dart';
import 'package:industry_app/screens/home_page/components/information_card.dart';
import 'package:industry_app/screens/home_page/components/pie_chart.dart';
import 'package:industry_app/screens/home_page/components/prediction_card.dart';
import 'package:industry_app/services/sendData.dart';
import 'package:industry_app/widgets/custom_line_chart.dart';
import 'package:provider/provider.dart';

import '../../../widgets/chart.dart';
import 'heading.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    SendData().getDashboardData(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(),
          defaultSpace3x,
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              DashboardModel dashboardModel = provider.dashboardModel;
              List<DayWiseDistribution> daywiseDistribution=dashboardModel.day_wise_waste;
              daywiseDistribution.sort((a, b) => (a.date).compareTo(b.date));
              // print(dashboardModel.predictions.length);
              return provider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        InformationCard(
                          pickup: dashboardModel.pickups,
                          totalWeight: dashboardModel.total_weight,
                        ),
                        defaultSpace3x,

                        PredictionCard(),
                        defaultSpace3x,
                        RecoveryChart(
                          wasteDistribution: dashboardModel.monthly_category_distribution,
                        ),
                        defaultSpace3x,
                        Charts(
                            xScale: "Days",
                            yScale: "Weight",
                            title: "Day wise distribution of Dustbin",
                            child: CustomLineChart(
                              label: List.generate(dashboardModel.day_wise_waste.length,
                                  (index) =>daywiseDistribution[index].date).toList(),
                              xAxis: [
                                List.generate(dashboardModel.day_wise_waste.length,
                                    (index) => index.toDouble()).toList()
                              ],
                              yAxis: [
                                List.generate(
                                    dashboardModel.day_wise_waste.length,
                                    (index) =>
                                        dashboardModel.day_wise_waste[index].total_weight).toList()
                              ],
                            ))
                      ],
                    );
            },
          )
        ],
      ),
    );
  }
}
