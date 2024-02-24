import 'package:flutter/material.dart';
import 'package:smart_bin/models/activity_model.dart';
import 'package:smart_bin/models/statistics_model.dart';
import 'package:smart_bin/services/api.dart';

import '../services/ApiBaseHelper.dart';

class StatisticsProvider extends ChangeNotifier {
  StatisticsModel _statistics = StatisticsModel(
      average_waste: [],
      daily_average_weigh: 0,
      highest_daily_waste:0,
      last_week_waste: 0,
      recovery_distribution:[] ,
      waste_distribution: []);
      bool isLoading = true;

  StatisticsModel get getStatistics => _statistics;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }
  void setStatistics(StatisticsModel statisticsModel){
    _statistics=statisticsModel;
   }

}
