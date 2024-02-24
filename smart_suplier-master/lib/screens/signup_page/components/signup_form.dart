import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/screens/home_page/home_screen.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/size_config.dart';
import 'package:smart_bin/utils/keyboard.dart';
import 'package:smart_bin/utils/validator.dart';
import 'package:smart_bin/widgets/buttons.dart';
import 'package:smart_bin/widgets/loading_dialog.dart';
import 'package:smart_bin/widgets/text.dart';
import 'package:smart_bin/widgets/textfield.dart';

class SignUpForm extends StatefulWidget {
  final String phoneNo;

  const SignUpForm({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? address;
  String? name;
  double? lat;
  double? lng;
  String _error = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: (newValue) => name = newValue,
            decoration: inputDecoration.copyWith(labelText: "Name"),
            validator: (val) => validateString(val, "name"),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.035,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: (newValue) => address = newValue,
            decoration: inputDecoration.copyWith(labelText: "Address"),
            validator: (val) => validateString(val, "address"),
            textInputAction: TextInputAction.done,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.035,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () async => getLocation(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              label: Text(
                'Get Your Current Location',
                style: titleBlack18.copyWith(color: Colors.blue),
              ),
              icon: Icon(
                Icons.gps_fixed,
                color: Colors.blue,
              ),
            ),
          ),
          defaultSpace3x,
          if (lat != null) Text('Latitude : $lat \nLongitude : $lng', style: titleBlack18,),
          Text(_error),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          DefaultButton(
              text: "Sign Up",
              press: () async {
                if (_formKey.currentState!.validate() && lat != null && lng != null) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  showLoaderDialog(context);
                 await  SendData().registerUser({
                    'phone': widget.phoneNo,
                    'name': name,
                    'address': address,
                    'lat': lat.toString(),
                    'lng': lng.toString()
                  }, context);
                } else if (lat == null) {
                  setState(() {
                    _error = "Please allow location service for dustbin";
                  });
                }
              }),
        ],
      ),
    );
  }

  getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    lat = _locationData.latitude;
    lng = _locationData.longitude;
    setState(() {});
  }
}
