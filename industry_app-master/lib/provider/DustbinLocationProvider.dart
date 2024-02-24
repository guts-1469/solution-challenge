import 'package:flutter/material.dart';
import 'package:industry_app/models/dustbin_location.dart';

class DustbinLocationProvider extends ChangeNotifier {
  List<DustbinLocation> _dustbinLocation =[];
  bool isLoading = true;

  List<DustbinLocation> get getDustbinLocation=> _dustbinLocation;

  void changeIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  void changePickedId(int index){
    _dustbinLocation[index].producer.picked_status=1;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setDustbinLocation(List<DustbinLocation> dustbinLocation) {
    _dustbinLocation = dustbinLocation;
  }
}
