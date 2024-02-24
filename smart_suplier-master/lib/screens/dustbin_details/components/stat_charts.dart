import 'package:flutter/material.dart';
import 'package:smart_bin/models/dustbin_details_model.dart';
import 'package:smart_bin/models/statistics_model.dart';

import '../../../constant.dart';
import '../../../widgets/chart.dart';
import '../../../widgets/custom_bar_chart.dart';
import '../../../widgets/custom_line_chart.dart';

class StatsChart extends StatefulWidget {
  const StatsChart({Key? key, required this.distribution})
      : super(key: key);
  final List<Distribution> distribution;

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  List<List<double>> averageWaste = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ];
  List<String> labels = [];
  Map<int, List<WasteDistribution>> dustbin = {};
  List<double> xCord = [];
  List<double> yCord = [];

  @override
  void initState() {
    for(int i=0;i<widget.distribution.length;i++){
      labels.add(widget.distribution[i].date);
      yCord.add(widget.distribution[i].quantity);
      xCord.add(i.toDouble());
    }


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        defaultSpace3x,
        Charts(
            xScale: "Days",
            yScale: "Weight",
            child: CustomLineChart(
              label: labels,
              xAxis: [xCord],
              yAxis: [yCord],
            ),
            title: "Day wise distribution of Dustbin"),
        defaultSpace3x,

      ],
    );
  }
}
