import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/widgets/text.dart';

class ChartSettings {
  List<String> label;

  ChartSettings({required this.label});

  SideTitles get bottomTitles => SideTitles(

        showTitles: true,
        reservedSize: 35,
        interval: 1,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          space: 10,
          child: Text(
            label[value.toInt()],
            style: titleBlack18.copyWith(fontSize: 13),
          ),
        ),
      );

  FlTitlesData get tilesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: (value, text) =>
                Text(value.toString(), style: titleBlack18.copyWith(fontSize: 13)),
            showTitles: true,
            reservedSize: 25,
          ),
        ),
      );

  FlGridData get gridData => FlGridData(
      getDrawingHorizontalLine: (double x) => FlLine(
            color: Color(0xffF1E7E7),
        strokeWidth: 1
          ),
      getDrawingVerticalLine: (double x) => FlLine(color: Color(0xffF1E7E7),strokeWidth: 1));
  FlBorderData get borderData=>FlBorderData(
    border: const Border(
      bottom: BorderSide(color: Color(0xffF1E7E7), width: 2),
      left: BorderSide(color: Color(0xffF1E7E7), width: 2),
      right: BorderSide(color: Color(0xffF1E7E7), width: 2),
      top: BorderSide(color: Color(0xffF1E7E7), width: 2),
    ),
  );
}
