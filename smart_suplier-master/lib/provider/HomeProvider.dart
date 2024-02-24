import 'package:flutter/cupertino.dart';
import 'package:smart_bin/models/dashboard_model.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = true;
  DashboardModel _dashboardModel = DashboardModel(
      daywiseDistribution: [],
      dustbinData: [],
      pickupSchedule: [],
      totalWeight: 0,
      wasteRecovery: []);

  void changeLoading() {
    isLoading =false;
    notifyListeners();
  }

  DashboardModel get dashboardModel => _dashboardModel;

  void setDashboard(DashboardModel dashboardModel) {
    _dashboardModel = dashboardModel;
    notifyListeners();
  }
}
