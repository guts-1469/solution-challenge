import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/models/dashboard_model.dart';
import 'package:smart_bin/provider/HomeProvider.dart';
import 'package:smart_bin/screens/food_category.dart';
import 'package:smart_bin/screens/home_page/components/information_card.dart';
import 'package:smart_bin/screens/home_page/components/pie_chart.dart';
import 'package:smart_bin/screens/profile/profile.dart';
import 'package:smart_bin/screens/wallet.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/widgets/buttons.dart';
import 'package:smart_bin/widgets/custom_line_chart.dart';
import 'package:smart_bin/widgets/text.dart';

import '../../../widgets/chart.dart';
import 'heading.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List labels = [];
  List<List<double>> xCord = [], yCord = [];

  getDetail(List<DayWiseDistribution> wasteDistribution) {
    Map<int, List<DayWiseDistribution>> dustbin = {};
    xCord.clear();
    yCord.clear();
    for (int i = 0; i < wasteDistribution.length; i++) {
      if (!dustbin.containsKey(wasteDistribution[i].id)) {
        dustbin[wasteDistribution[i].id] = [wasteDistribution[i]];
      } else {
        dustbin[wasteDistribution[i].id]?.add(wasteDistribution[i]);
      }
    }

    for (var value in dustbin.values) {
      value.sort((a, b) => a.day.compareTo(b.day));
      List<double> x = [], y = [];
      for (DayWiseDistribution element in value) {
        x.add((element.day).toDouble());
        y.add(element.quantity);
      }
      print(x);
      xCord.add(x);
      yCord.add(y);
    }
    print('Hello');
    print(xCord);
    print(yCord);
  }

  @override
  void initState() {
    SendData().getDashboardData(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Heading(),
        ),
        Consumer<HomeProvider>(
          builder: (context, provider, child) {
            DashboardModel dashboardModel = provider.dashboardModel;
            Map<String, List<List>> cordinates = {};
            Map<String, double> dataMap = {};
            getDetail(dashboardModel.daywiseDistribution);

            for (int i = 0; i < dashboardModel.wasteRecovery.length; i++) {
              dataMap[dashboardModel.wasteRecovery[i].tag_name] =
                  dashboardModel.wasteRecovery[i].total_weight;
            }
            return provider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InformationCard(
                          dustbinData: dashboardModel.dustbinData,
                          totalWaste: dashboardModel.totalWeight.toString(),
                        ),
                        defaultSpace2x,
                       if(dashboardModel.pickupSchedule.isNotEmpty)
                        DumperNotification(pickUp: dashboardModel.pickupSchedule),
                        defaultSpace2x,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedIconBtn(
                              text: Text(
                                'Wallet',
                                style: titleWhite20,
                              ),
                              icon: Icons.account_balance_wallet_outlined,
                              press: () {
                                Navigator.pushNamed(context, WalletScreen.routeName);
                              },
                              width: 165,
                              height: 40,
                              borderRadius: 10,
                            ),
                            RoundedIconBtn(
                              text: Text(
                                'Profile',
                                style: titleWhite20,
                              ),
                              icon: Icons.account_circle_outlined,
                              press: () {
                                Navigator.pushNamed(context, ProfileScreen.routeName);
                              },
                              width: 165,
                              height: 40,
                              borderRadius: 10,
                            )
                          ],
                        ),
                        defaultSpace3x,
                        RecoveryChart(dataMap: dataMap),
                        defaultSpace3x,
                        Charts(
                            xScale: "Days",
                            yScale: "Weight",
                            child: CustomLineChart(
                              label: const ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                              xAxis: xCord,
                              yAxis: yCord,
                            ),
                            title: "Day wise distribution of Dustbin")
                      ],
                    ),
                  );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context,FoodCategory.routeName);
              },
              icon: const Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              label: Text(
                "Add new dutbin",
                style: titleWhite18,
              ),
              style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
            ),
          ),
        )
      ],
    );
  }
}

class DumperNotification extends StatelessWidget {
  const DumperNotification({Key? key, required this.pickUp}) : super(key: key);
  final List<PickupSchedule> pickUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * .95,
      height: 60,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.circular(12)),
      child: PageView.builder(
          itemCount: pickUp.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/icons/dumper.svg',
                  height: getProportionateScreenWidth(15),
                ),
                Text(
                  'Dumper will arrive on ${formatDateMMMd(pickUp[index].pickup_date)}',
                  style: titleBlack18,
                )
              ],
            );
          }),
    );
  }
}
