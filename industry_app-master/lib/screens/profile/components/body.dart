import 'package:flutter/material.dart';
import 'package:industry_app/constant.dart';
import 'package:industry_app/provider/UserProvider.dart';
import 'package:industry_app/screens/login_page/sing_in_screen.dart';
import 'package:industry_app/screens/signup_page/signup.dart';
import 'package:industry_app/services/save_preference.dart';
import 'package:industry_app/services/sendData.dart';
import 'package:industry_app/size_config.dart';
import 'package:industry_app/widgets/buttons.dart';
import 'package:industry_app/widgets/loading_dialog.dart';
import 'package:industry_app/widgets/text.dart';
import 'package:industry_app/widgets/textfield.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isEdit = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    TextEditingController name=TextEditingController();

    TextEditingController address=TextEditingController();

    name.text=userProvider.name;
    address.text=userProvider.address;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            backButton(context),
            Text(
              'Profile',
              style: headingBlack27,
            ),
            defaultSpace3x,
            Container(
              child: Center(
                child: CircleAvatar(
                  radius: SizeConfig.screenWidth * 0.2,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),

            defaultSpace3x,
            TextFormField(

              decoration: inputDecoration.copyWith(labelText: 'Name',filled: isEdit,fillColor: Colors.grey.shade300),
              readOnly: !isEdit,
              controller: name,
              validator: (val) => (val == null || val.isEmpty) ? "Enter Name" : null,
            ),
            defaultSpace3x,
            TextFormField(
              initialValue: userProvider.phone,
              decoration: inputDecoration.copyWith(labelText: 'Phone'),
              readOnly: true,
            ),

            defaultSpace3x,
            TextFormField(
              controller: address,
              decoration: inputDecoration.copyWith(labelText: 'Address',filled: isEdit,fillColor: Colors.grey.shade300),
              readOnly: !isEdit,

              validator: (val) => (val == null || val.isEmpty) ? "Enter Address" : null,
            ),

            defaultSpace3x,
            !isEdit
                ? DefaultButton(
                    text: 'Edit Profile',
                    press: () {
                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                  )
                : DefaultButton(
                    text: 'Save Profile',
                    press: () async{
                      showLoaderDialog(context);
                      await SendData().updateConsumerProfile({
                        'consumer_id':userProvider.id.toString(),
                        'consumer_name':name.text,
                        'consumer_address':address.text,
                      },context);


                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                  ),
            defaultSpace3x,
            DefaultButton(text: 'Logout',press: () async {
              SettingProvider settingProvider=Provider.of<SettingProvider>(context,listen: false);
              await settingProvider.clearUserSession(context);
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (route) => false);
            },)
          ],
        ),
      ),
    );
  }
}
