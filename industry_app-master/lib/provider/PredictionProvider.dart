import 'package:flutter/cupertino.dart';
import 'package:industry_app/models/prediction_model.dart';

class PredictionProvider extends ChangeNotifier{
  List<PredictionModel> _predictions=[];
  bool predictionLoading=true;
  void updatePrediction(List<PredictionModel>prediction){
    _predictions=prediction;
    predictionLoading=false;
    notifyListeners();
  }
  get preditiction=>_predictions;
  void startLoading(){
    predictionLoading=true;
    notifyListeners();
  }
}