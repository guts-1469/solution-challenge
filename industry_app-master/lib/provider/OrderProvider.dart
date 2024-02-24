import 'package:flutter/material.dart';
import 'package:industry_app/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
  bool isLoading = true;

  List<OrderModel> get orders => _orders;

  void changeIsLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setDustbins(order) {
    _orders = order;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }
}
