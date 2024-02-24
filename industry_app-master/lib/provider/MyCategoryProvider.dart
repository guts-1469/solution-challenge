import 'package:flutter/cupertino.dart';
import 'package:industry_app/models/category_model.dart';

class MyCategoryProvider extends ChangeNotifier{
  List<MyCategoryModel>_categoryList=[];
  List<MyCategoryModel> get categories=>_categoryList;
  void setCategory(List<MyCategoryModel>categoryList){
    _categoryList=categoryList;
    notifyListeners();
  }

}