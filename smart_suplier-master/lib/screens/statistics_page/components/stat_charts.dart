import 'package:flutter/material.dart';
import 'package:smart_bin/models/statistics_model.dart';

import '../../../constant.dart';
import '../../../widgets/chart.dart';
import '../../../widgets/custom_bar_chart.dart';
import '../../../widgets/custom_line_chart.dart';

class StatsChart extends StatefulWidget {
  const StatsChart({Key? key, required this.averageWaste, required this.wasteDistribution,required this.recoveryDistribution})
      : super(key: key);
  final List<AverageWaste> averageWaste;
  final List<WasteDistribution> wasteDistribution;
  final List<RecoverDistribution>recoveryDistribution;

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
  List<List<double>> xCord = [];
  List<List<double>> yCord = [];

  List<List<double>>yCordRecovery=[];
  @override
  void initState() {
    dayWeightCoordinate();
    recoveryDistribution();
    // TODO: implement initState
    super.initState();
  }
  void recoveryDistribution(){
    yCordRecovery.clear();
    Map<String,List<RecoverDistribution>> distributions={};

    for(RecoverDistribution distri in widget.recoveryDistribution){
      if(!distributions.containsKey(distri.tag_name)){
        distributions[distri.tag_name]=[distri];
      }
      else{
        distributions[distri.tag_name]!.add(distri);
      }
    }
    for(int i=0;i<7;i++){
      yCordRecovery.add(List.generate(dustbin.length+1, (index) => 0.toDouble()));
    }
    int i=0;
    for(List<RecoverDistribution>value in distributions.values){
      for(int j=0;j<value.length;j++) {

        yCordRecovery[value[j].day][i]=value[j].total_weight;
      }
      i++;
    }
  }

  void dayWeightCoordinate() {
    // xCord.clear();
    // yCord.clear();
    // averageWaste.clear();
    // labels.clear();
    // dustbin.clear();
    for (int i = 0; i < widget.averageWaste.length; i++) {
      averageWaste[widget.averageWaste[i].day] = [0, widget.averageWaste[i].quantity];
    }
    for (int i = 0; i < widget.wasteDistribution.length; i++) {
      if (!labels.contains(widget.wasteDistribution[i].day)) {
        labels.add(widget.wasteDistribution[i].day);
      }
      if (!dustbin.containsKey(widget.wasteDistribution[i].dustbin_id)) {
        print(widget.wasteDistribution[i].dustbin_id);
        dustbin[widget.wasteDistribution[i].dustbin_id] = [widget.wasteDistribution[i]];
      } else
        dustbin[widget.wasteDistribution[i].dustbin_id]?.add(widget.wasteDistribution[i]);
    }
    for (var value in dustbin.values) {
      yCord.add(value.map((dustbin) => dustbin.quantity).toList());
    }
    xCord.add(List<double>.generate(labels.length, (i) => i.toDouble()));
    print(yCord);
  }
  void makeRecoveryChart(){

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Charts(
          xScale: 'Day',
          yScale: 'Weight',
          title: "Average Waste Weekly",
          child: CustomBarChart(
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            yAxis: averageWaste,
            xAxis: [0, 1, 2, 3, 4, 5, 6],
          ),
        ),
        defaultSpace3x,
        Charts(
            xScale: "Days",
            yScale: "Weight",
            child: CustomLineChart(
              label: labels,
              xAxis: xCord,
              yAxis: yCord,
            ),
            title: "Day wise distribution of Dustbin"),
        defaultSpace3x,
        Charts(
          xScale: 'Day',
          yScale: 'Weight',
          title: "Average Waste Weekly",
          child: CustomBarChart(
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            yAxis: yCordRecovery,
            xAxis: [0, 1, 2, 3, 4, 5, 6],
          ),
        ),
      ],
    );
  }
}
