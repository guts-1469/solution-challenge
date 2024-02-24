import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/services/ApiBaseHelper.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/widgets/buttons.dart';
import 'package:smart_bin/widgets/loading_dialog.dart';
import 'package:smart_bin/widgets/text.dart';
import 'package:smart_bin/widgets/textfield.dart';

import '../models/category_model.dart';
import '../services/api.dart';
import '../size_config.dart';

class FoodCategory extends StatefulWidget {
  static String routeName = "/food_category";

  const FoodCategory({Key? key}) : super(key: key);

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  bool isError = false;
  int? selectedCategory;
  List<CategoryModel> allCategories = [];
  bool _isLoading = true;
  TextEditingController _dustbinName = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  getCategories() async {
    var getdata = await apiBaseHelper.getAPICall(get_categories);
    bool error = getdata['error'] ?? false;
    if (!error) {
      allCategories = (getdata['data'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _isLoading = false;
      setState(() {});
    }else{
      print(getdata['msg']??"Error");
      setSnackbar(getdata['msg']??"Error",context);
    }
  }
  @override
  void initState() {
    getCategories();
    // TODO: implement initState
    super.initState();
  }

  Widget categoryGrid() {
    return Expanded(
      child: GridView.builder(
          scrollDirection: Axis.vertical,

          // shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: allCategories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                selectedCategory = allCategories[index].id;
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (selectedCategory != null && selectedCategory == allCategories[index].id)
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
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        // bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defaultSpace,
                    Text(
                      'Select Categories',
                      style: headingBlack27.copyWith(),
                    ),
                    Text(
                      'For dustbin #1234',
                      style:
                          titleBlack18.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    defaultSpace2x,

                    _isLoading ? const CircularProgressIndicator() : categoryGrid(),
                    // defaultSpace2x,
                    if (isError)
                      Text('Please Select any category',
                          style: titleBlack18.copyWith(color: Colors.red)),
                  ],
                ),
              ),
            ),
            if (!_isLoading)
              Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                elevation: 18,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: SizeConfig.screenHeight * .20,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        child: TextFormField(
                          decoration: inputDecoration.copyWith(labelText: 'Dustbin Name'),
                          validator: (val) =>
                              val == null || val.isEmpty ? "Please enter dustbin name" : null,
                        controller: _dustbinName,
                        ),
                        key: _formKey,
                      ),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          if (selectedCategory != null && _formKey.currentState!.validate()) {
                            showLoaderDialog(context);
                            SendData().addDustbin(
                                selectedCategory.toString(), _dustbinName.text, context);
                          } else if (selectedCategory == null) {
                            isError = true;
                            setState(() {});
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
