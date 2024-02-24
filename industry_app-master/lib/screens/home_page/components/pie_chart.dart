import 'package:flutter/material.dart';
import 'package:industry_app/models/statistics_model.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:industry_app/widgets/text.dart';

import '../../../models/dashboard_model.dart';
class RecoveryChart extends StatefulWidget {
  RecoveryChart({Key? key,required this.wasteDistribution}) : super(key: key);
  List<WasteRecoveryDistribution> wasteDistribution;

  @override
  State<RecoveryChart> createState() => _RecoveryChartState();
}

class _RecoveryChartState extends State<RecoveryChart> {
  Map<String, double> dataMap = {};

   List<Color>colorList=[
    const Color(0xff67C587),
    const Color(0xffA9DEBA),
    const Color(0xffC9EAD4),
    const Color(0xffD9D9D9)
  ];
   @override
  void initState() {
     for(int i=0;i<widget.wasteDistribution.length;i++){
       dataMap[widget.wasteDistribution[i].category_name]=widget.wasteDistribution[i].total_weight;
     }
     setState(() {

     });
     // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Waste Recovery Distribution',style: titleBlack20,),
          ),
          
          (widget.wasteDistribution.isEmpty)?
              Padding(padding: EdgeInsets.all(15), child: Text('No data Available',style: titleBoldBlack20,)):
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 12,
            chartRadius: MediaQuery.of(context).size.width / 1.5,      colorList: colorList,
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
