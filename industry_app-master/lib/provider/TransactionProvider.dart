import 'package:flutter/cupertino.dart';
import 'package:industry_app/models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  bool isLoading = true;
  List<TransactionModel> _transactionModel = [];

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  List<TransactionModel> get transactionModel => _transactionModel;

  void setDashboard(List<TransactionModel> transactionModel) {
    _transactionModel = transactionModel;
    notifyListeners();
  }
}
