import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../constant.dart';
import '../../../models/category_model.dart';
import '../../../services/sendData.dart';
import '../../../size_config.dart';
import '../../../utils/keyboard.dart';
import '../../../utils/validator.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/text.dart';
import '../../../widgets/textfield.dart';

class SignUpForm extends StatefulWidget {
  final String phoneNo;

  const SignUpForm({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? address;
  String? estimatedWaste;
  String? name;
  double? lat;
  double? lng;
  String _error = "";
  final _formKey = GlobalKey<FormState>();
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: (newValue) => estimatedWaste = newValue,
            decoration: inputDecoration.copyWith(labelText: "Estimated Waste"),
            validator: (val) => validateString(val, "estimated waste"),
            textInputAction: TextInputAction.done,
          ),
          defaultSpace3x,
          Text(
            'Select Your Company Tag',
            style: titleBlack20,
          ),
          defaultSpace2x,
          Wrap(
            spacing: 15,
            children: List.generate(
              tags.length,
              (index) => Container(
                child: ChoiceChip(
                  label: Text(
                    tags[index].tagName,
                    style: titleBlack18,
                  ),
                  selected: selectedTags.contains(tags[index].id.toString()),
                  selectedColor:Colors.blue.withOpacity(0.4) ,
                  onSelected: (bool value) {
                    if (value) {
                      selectedTags.add(tags[index].id.toString());
                    } else {
                      selectedTags.remove(tags[index].id.toString());
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
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
          if (lat != null)
            Text(
              'Latitude : $lat \nLongitude : $lng',
              style: titleBlack18,
            ),
          Text(_error),
          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),
          DefaultButton(
              text: "Sign Up",
              press: () async {
                if (_formKey.currentState!.validate() && lat != null && lng != null&&selectedTags.isNotEmpty) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  // showLoaderDialog(context);
                  await SendData().registerUser({
                    'consumer_phone': widget.phoneNo,
                    'consumer_name': name,
                    'consumer_address': address,
                    'lat': lat.toString(),
                    'lng': lng.toString(),
                    'estimated_waste_quantity': estimatedWaste,
                    'consumer_tags':selectedTags,
                  }, context);
                } else if (lat == null) {
                  setState(() {
                    _error = "Please allow location service for dustbin";
                  });
                }
                else{
                  setState(() {
                    _error = "Please select a tag";
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
