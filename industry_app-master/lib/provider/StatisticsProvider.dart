import 'package:flutter/material.dart';
import 'package:industry_app/models/statistics_model.dart';

class StatisticsProvider extends ChangeNotifier {
  StatisticsModel _statistics = StatisticsModel(
      category_distribution: [],
      day_cost_distribution: [],
      distance_distribution: [],
      food_waste_distribution: [],
      total_dustbin_pickups: DustbinPickUp(total_distance: 0, total_cost: 0, total_weight: 0));
  bool isLoading = true;

  StatisticsModel get getStatistics => _statistics;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setStatistics(StatisticsModel statisticsModel) {
    _statistics = statisticsModel;
  }
}
