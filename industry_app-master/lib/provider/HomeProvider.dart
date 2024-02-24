import 'package:flutter/cupertino.dart';
import 'package:industry_app/models/dashboard_model.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = true;
  DashboardModel _dashboardModel = DashboardModel(
      pickups: [],
      monthly_category_distribution: [],
      total_weight: 0,
      day_wise_waste: []);

  void changeLoading() {
    isLoading = false;
    notifyListeners();
  }

  DashboardModel get dashboardModel => _dashboardModel;

  void setDashboard(DashboardModel dashboardModel) {
    _dashboardModel = dashboardModel;
    notifyListeners();
  }
}
