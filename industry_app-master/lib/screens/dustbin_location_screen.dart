import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industry_app/models/dustbin_location.dart';
import 'package:industry_app/provider/DustbinLocationProvider.dart';
import 'package:industry_app/screens/orders/components/order_card.dart';
import 'package:industry_app/services/ApiBaseHelper.dart';
import 'package:industry_app/services/sendData.dart';
import 'package:industry_app/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
import '../services/api.dart';
import '../size_config.dart';
import '../widgets/buttons.dart';
import '../widgets/text.dart';

class DustbinLocationScreen extends StatefulWidget {
  static String routeName = '/dustbin_location_screen';

  DustbinLocationScreen({Key? key, required this.pickup_id}) : super(key: key);
  String pickup_id;

  @override
  State<DustbinLocationScreen> createState() => _DustbinLocationScreenState();
}

class _DustbinLocationScreenState extends State<DustbinLocationScreen> {
  @override
  void initState() {
    SendData().getDustbinLocation(context, widget.pickup_id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        // bottom: false,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButton(context),
                  Text(
                    'Dustbin Location',
                    style: headingBlack27,
                  ),
                  Consumer<DustbinLocationProvider>(builder: (context, provider, child) {
                    List<DustbinLocation> dustbinLocationList = provider.getDustbinLocation;
                    return provider.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              defaultSpace2x,
                              const ListTile(
                                leading: Icon(
                                  Icons.navigation_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                title: Text(
                                  'All Dustbin Location',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  '( Click to view )',
                                  style: TextStyle(color: Colors.white),
                                ),
                                tileColor: kPrimaryColor,
                              ),
                              defaultSpace2x,
                              ...List.generate(dustbinLocationList.length, (index) {
                                DustbinLocation dustbinLocation = dustbinLocationList[index];
                                return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Column(children: [
                                    ...List.generate(
                                        dustbinLocation.dustbins.length,
                                        (i) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Dustbin #${dustbinLocation.dustbins[i].dustbin_id}',
                                                  style: titleBlack20.copyWith(
                                                      color: kPrimaryColor,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                defaultSpace2x,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    customListTile('Category',
                                                        dustbinLocation.dustbins[i].category_name),
                                                    customListTile('Total Weight',
                                                        '${dustbinLocation.dustbins[i].total_weight} kg')
                                                  ],
                                                ),
                                                defaultSpace3x,
                                              ],
                                            )),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: customListTile(
                                          "Address", dustbinLocation.producer.address),
                                    ),
                                    defaultSpace3x,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                            text: Text(
                                              'Open in Map',
                                              style: titleWhite18,
                                            ),
                                            press: () async {
                                              await openMap(dustbinLocation.producer.lat,
                                                  dustbinLocation.producer.lng);
                                            },
                                            width: SizeConfig.screenWidth * .37),
                                        (dustbinLocation.producer.picked_status == 0)
                                            ? CustomButton(
                                                text: Text(
                                                  'Mark as Picked',
                                                  style: titleWhite18,
                                                ),
                                                press: () async {
                                                  showLoaderDialog(context);
                                                  var getdata = await apiBaseHelper.postAPICall(
                                                      mark_pick_up,
                                                      {'producer_id': '1', 'pickup_id': '1'});
                                                  Navigator.pop(context);
                                                  bool error = getdata['error'] ?? false;
                                                  if (getdata['code'] == 200) {
                                                    provider.changePickedId(index);
                                                  }
                                                },
                                                color: Color(0xff00706B),
                                                width: SizeConfig.screenWidth * .37)
                                            : Text(
                                                'Picked',
                                                style: titleBoldBlack20.copyWith(
                                                    color: Color(0xff00706B)),
                                              ),
                                      ],
                                    )
                                  ]),
                                );
                              })
                            ],
                          );
                  })
                ],
              ),
            )),
      ),
    );
  }

  customRowTile(String title, String weight, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleBlack18,
        ),
        Row(
          children: [
            Text(
              weight,
              style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              price,
              style: titleBlack18,
            ),
          ],
        )
      ],
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    final Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
      await launchUrl(googleUrl);

  }
}
