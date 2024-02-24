import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/constant.dart';
import 'package:industry_app/models/category_model.dart';
import 'package:industry_app/provider/UserProvider.dart';
import 'package:industry_app/screens/home_page/home_screen.dart';
import 'package:industry_app/services/ApiBaseHelper.dart';
import 'package:industry_app/services/api.dart';
import 'package:industry_app/services/save_preference.dart';
import 'package:industry_app/widgets/buttons.dart';
import 'package:industry_app/widgets/text.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';
import '../utils/keyboard.dart';
import '../widgets/loading_dialog.dart';

class FoodCategory extends StatefulWidget {
  static String routeName = "/food_category";

  const FoodCategory({Key? key}) : super(key: key);

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  bool isError = false;
  List selectedCategory = [];
  bool _isLoading = true;
  List prices = [];
  List<CategoryModel> allCategories = [];
  String error = "";
  final _formKey = GlobalKey<FormState>();
  Set<int> s = Set();

  getCategories() async {
    var getdata = await apiBaseHelper.getAPICall(get_categories);
    bool error = getdata['error'] ?? false;
    if (!error) {
      allCategories = (getdata['data'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    super.initState();
  }

  Widget categoryGrid() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: allCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (selectedCategory.contains(allCategories[index].id))
                selectedCategory.remove(allCategories[index].id);
              else
                selectedCategory.add(allCategories[index].id);

              Map mp = {
                'category_id': allCategories[index].id.toString(),
                'price_per_unit': "100"
              };
              if (!prices.contains(mp)) prices.add(mp);
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (selectedCategory.contains(allCategories[index].id))
                    ? const Color(0xFFD2EBF1)
                    : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: allCategories[index].category_image,
                      height: SizeConfig.screenWidth * 0.25,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    SizedBox(
                      height: defaultHeight,
                    ),
                    Text(
                      allCategories[index].category_name,
                      style: titleBlack20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String consumerId = Provider.of<UserProvider>(context, listen: false).id.toString();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultSpace,
                Text(
                  'Select Food Categories',
                  style: headingBlack27.copyWith(),
                ),
                defaultSpace2x,
                _isLoading
                    ? CircularProgressIndicator()
                    : Form(key: _formKey, child: categoryGrid()),
                defaultSpace2x,
                Text(error, style: titleBlack18.copyWith(color: Colors.red)),
                defaultSpace2x,
                DefaultButton(
                  text: "Continue",
                  press: () async {
                    if (selectedCategory.isNotEmpty) {
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);
                      showLoaderDialog(context);
                      var dio = Dio();
                      Response response = await dio.post(baseUrl + '/consumer/user/categories',
                          data: {'consumer_id': consumerId, 'selected_categories': prices});
                      var getdata=response.data;
                      Navigator.pop(context);
                      if (getdata['code'] == 200) {
                        print(getdata['data']);
                        SettingProvider settingProvider=Provider.of<SettingProvider>(context,listen: false);
                        settingProvider.setPrefrenceBool("isCategory", true);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else {
                        print(getdata['code']);
                        setSnackbar(getdata['msg'], context);
                      }
                    } else if (selectedCategory.isEmpty) {
                      error = "Please Select Category";
                      setState(() {});
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
