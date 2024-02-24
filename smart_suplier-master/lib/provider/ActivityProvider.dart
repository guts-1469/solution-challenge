import 'package:flutter/material.dart';
import 'package:smart_bin/models/activity_model.dart';
import 'package:smart_bin/services/api.dart';

import '../services/ApiBaseHelper.dart';

class ActivityProvider extends ChangeNotifier {
  List<ActivityModel> _activity = [];
  bool isLoading = true;

  List<ActivityModel> get activites => _activity;

  get activities => _activity;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
  void setActivities(activity){_activity = activity;notifyListeners();}
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }
}
