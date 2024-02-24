import 'package:flutter/material.dart';
import 'package:smart_bin/models/dustbin_details_model.dart';
import 'package:smart_bin/models/dustbin_model.dart';

class DustbinDetailsProvider extends ChangeNotifier {
  DustbinDetailsModel _detailsModel = DustbinDetailsModel(
      distribution: [],
      dustbin: DustbinModel(
          id: 0,
          current_capacity: 0.0,
          created_at: DateTime.now(),
          category_name: "category_name",
          current_depth: 0,
          dustbin_name: "",
          dustbin_status: 0,
          total_capacity: 0.0),
      last_week_waste: 0,
      daily_average_weight: 0,
      dustbin_weight: 0,
      highest_daily_weight: 0);
  bool isLoading = true;

  DustbinDetailsModel get getDetailsModel => _detailsModel;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void setDustbins(detailsModel) {
    _detailsModel = detailsModel;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }
}
