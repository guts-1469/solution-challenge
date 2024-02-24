import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/widgets/chart_settings.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({Key? key, required this.labels, required this.yAxis, required this.xAxis})
      : super(key: key);
  final List<String> labels;
  final List<int> xAxis;
  final List<List<double>> yAxis;

  @override
  Widget build(BuildContext context) {
    final charSettings = ChartSettings(label: labels);
    return BarChart(
      BarChartData(
        borderData: charSettings.borderData,
        gridData: charSettings.gridData,
        titlesData: charSettings.tilesData,
        barGroups: List.generate(
          xAxis.length,
          (index) => BarChartGroupData(x: xAxis[index], barRods: [
            BarChartRodData(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(12)),
                toY: yAxis[index].last,
                fromY: 0,
                rodStackItems: List.generate(
                    yAxis[index].length - 1,
                    (j) => BarChartRodStackItem(
                        yAxis[index][j], yAxis[index][j + 1], barChartColor[j])),
                width: 34)
          ]),
        ),
      ),
      swapAnimationDuration: defaultDuration, // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
