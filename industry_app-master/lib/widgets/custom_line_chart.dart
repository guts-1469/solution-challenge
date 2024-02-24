import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/widgets/text.dart';

import '../constant.dart';
import 'chart_settings.dart';

class CustomLineChart extends StatelessWidget {
  CustomLineChart({
    Key? key,
    required this.label,
    required this.xAxis,
    required this.yAxis,
  }) : super(key: key);

  List<List<double>> xAxis, yAxis;
  List<String> label;

  @override
  Widget build(BuildContext context) {

    ChartSettings chartSettings = ChartSettings(label: label);
    return label.isEmpty?Text('No Data Available',style: titleBoldBlack20,): LineChart(
      LineChartData(
           borderData: chartSettings.borderData,
          gridData: chartSettings.gridData,
          titlesData: chartSettings.tilesData,
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(tooltipBgColor: backgroundColor)),
          lineBarsData: List.generate(
              xAxis.length,
              (index) => LineChartBarData(
                  isCurved: true,
                  color: lineCharColor[index],
                  barWidth: 3,
                  spots: List.generate(
                      xAxis[index].length, (j) => FlSpot(xAxis[index][j], yAxis[index][j]))))
          // read about it in the LineChartData section
          ),
      swapAnimationDuration: Duration(milliseconds: 200), // Optional
      swapAnimationCurve: Curves.easeIn, // Optional
    );
  }
}
