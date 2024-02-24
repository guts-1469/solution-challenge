import 'package:flutter/cupertino.dart';
import 'package:smart_bin/models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  bool isLoading = true;
  List<TransactionModel> _transactionModel = [];

  void changeLoading() {
    isLoading =false;
    notifyListeners();
  }

  List<TransactionModel> get transactionModel => _transactionModel;

  void setDashboard(List<TransactionModel> transactionModel) {
    _transactionModel = transactionModel;
    notifyListeners();
  }
}
