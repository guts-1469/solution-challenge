import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bin/models/dustbin_model.dart';
import 'package:smart_bin/screens/dustbin_details/dustbin_details.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import '../../../widgets/text.dart';

class DustBinCard extends StatelessWidget {
  const DustBinCard({Key? key, required this.dustbin}) : super(key: key);
  final DustbinModel dustbin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dustbin #${dustbin.id}',
                  style: titleWhite18.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w800),
                ),
                Container(
                  color: dustbin.dustbin_status == 0 ? Color(0xffD65152) : Color(0xff02BAA8),
                  padding: EdgeInsets.all(5),
                  child: Text(dustbin.dustbin_status == 0 ? "Inactive" : "Active",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            defaultSpace2x,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customListTile('Name', dustbin.dustbin_name),
                customListTile('Created On', formatDateMMMd(dustbin.created_at))
              ],
            ),
            defaultSpace2x,
            DottedLine(),
            defaultSpace2x,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customListTile('Capacity Left',(100- ((dustbin.current_capacity*100)/dustbin.total_capacity)).toStringAsPrecision(2)+ " %") ,

                customListTile('Total Capicity', '${dustbin.total_capacity} kg')
              ],
            ),
            defaultSpace2x,
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DustbinDetails(id: dustbin.id.toString(),dustbin:dustbin)));
                },
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  primary: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      "View More Details",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(17), color: Colors.white),
                    ),
                    Icon(CupertinoIcons.right_chevron),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customListTile(String heading, String subheading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.bold,
              color: Color(0xff89898A)),
        ),
        defaultSpace,
        Text(
          subheading,
          style: titleBlack18.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
