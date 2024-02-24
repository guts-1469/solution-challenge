import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SpinKitFoldingCube(
          color: Colors.green,
          size: 50.0,
        ),
      );
    },
  );
}
