import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/statistics_model.dart';
import '../../../widgets/chart.dart';
import '../../../widgets/custom_bar_chart.dart';
import '../../../widgets/custom_line_chart.dart';

class StatsChart extends StatefulWidget {
  StatsChart(
      {Key? key,
      required this.categoryDistribution,
      required this.distanceDistribution,
      required this.foodWasteDistribution,
      required this.dayCostDistribution})
      : super(key: key);

  List<CategoryDistribution> categoryDistribution;
  List<DayCostDistribution> dayCostDistribution;
  List<DistanceDistribution> distanceDistribution;
  List<FoodWasteDistribution> foodWasteDistribution;

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
  Map<String, List<CategoryDistribution>> categories = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.categoryDistribution.length; i++) {
      if (categories.containsKey(widget.categoryDistribution[i].tag_name))
        categories[widget.categoryDistribution[i].tag_name]?.add(widget.categoryDistribution[i]);
      else {
        categories[widget.categoryDistribution[i].tag_name] = [widget.categoryDistribution[i]];
      }
    }
    List<List<double>> cat = [];
    for (int i = 0; i < 7; i++) {
      cat.add(List.generate(categories.length + 1, (index) => 0.toDouble()).toList());
    }
    print(cat);
    int i = 1;
    for (List<CategoryDistribution> value in categories.values) {
      for (int j = 0; j < value.length; j++) {
        print('${days[value[j].day]} $i');
        cat[days[value[j].day]][i] = cat[days[value[j].day]][i - 1] + value[j].total_weight;
      }
      i++;
    }
    averageWaste = cat;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultSpace3x,
        Charts(
            xScale: "Days",
            yScale: "Cost",
            title: "Day vs Cost Graph",
            child: CustomLineChart(
              label: List.generate(widget.dayCostDistribution.length,
                  (index) => widget.dayCostDistribution[index].date).toList(),
              xAxis: [
                List.generate(widget.dayCostDistribution.length, (index) => index.toDouble())
                    .toList()
              ],
              yAxis: [
                List.generate(widget.dayCostDistribution.length,
                    (index) => widget.dayCostDistribution[index].total_cost).toList()
              ],
            )),
        Charts(
            xScale: "Days",
            yScale: "Food Waste",
            title: "Day vs Food Waste Graph",
            child: CustomLineChart(
              label: List.generate(widget.foodWasteDistribution.length,
                  (index) => widget.foodWasteDistribution[index].date).toList(),
              xAxis: [
                List.generate(widget.foodWasteDistribution.length, (index) => index.toDouble())
                    .toList()
              ],
              yAxis: [
                List.generate(widget.foodWasteDistribution.length,
                    (index) => widget.foodWasteDistribution[index].total_weight).toList()
              ],
            )),
        Charts(
            xScale: "Days",
            yScale: "Distance",
            title: "Distance Travelled",
            child: CustomLineChart(
              label: List.generate(widget.distanceDistribution.length,
                  (index) => widget.distanceDistribution[index].date).toList(),
              xAxis: [
                List.generate(widget.distanceDistribution.length, (index) => index.toDouble())
                    .toList()
              ],
              yAxis: [
                List.generate(widget.distanceDistribution.length,
                    (index) => widget.distanceDistribution[index].total_distance).toList()
              ],
            )),
        defaultSpace3x,
        Charts(
          xScale: 'Day',
          yScale: 'Weight',
          title: "Category Distribution",
          child: CustomBarChart(
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            yAxis: averageWaste,
            xAxis: [0, 1, 2, 3, 4, 5, 6],
          ),
        ),
      ],
    );
  }
}
