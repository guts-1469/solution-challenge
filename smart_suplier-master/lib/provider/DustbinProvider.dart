import 'package:flutter/material.dart';
import 'package:smart_bin/models/dustbin_model.dart';

class DustbinProvider extends ChangeNotifier {
  List<DustbinModel> _dustbins = [];
  bool isLoading = true;

  List<DustbinModel> get dustbins => _dustbins;

  void changeIsLoading() {
    isLoading =false;
    notifyListeners();
  }

  void setDustbins(dustbin) {
    _dustbins = dustbin;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }
}
