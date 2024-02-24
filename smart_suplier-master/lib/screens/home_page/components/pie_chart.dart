import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smart_bin/widgets/text.dart';

class RecoveryChart extends StatelessWidget {
  RecoveryChart({Key? key,required this.dataMap}) : super(key: key);
  Map<String, double> dataMap;
  List<Color> colorList = [
    const Color(0xff67C587),
    const Color(0xffA9DEBA),
    const Color(0xffC9EAD4),
    const Color(0xffD9D9D9)
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(dataMap.length!=0)
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Waste Recovery Distribution',
              style: titleBlack20,
            ),
          ),
          if(dataMap.length!=0)
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 12,
            chartRadius: MediaQuery.of(context).size.width / 1.5,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        ],
      ),
    );
  }
}
