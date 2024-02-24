import 'package:flutter/cupertino.dart';
import 'package:industry_app/models/category_model.dart';

class CategoryProvider extends ChangeNotifier{
  List<CategoryModel>_categoryList=[];
  List<CategoryModel> get categories=>_categoryList;
  void setCategory(List<CategoryModel>categoryList){
    _categoryList=categoryList;
    notifyListeners();
  }

}