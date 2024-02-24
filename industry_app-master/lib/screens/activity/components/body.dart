import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';
import '../../../models/activity_model.dart';
import '../../../provider/ActivityProvider.dart';
import '../../../provider/UserProvider.dart';
import '../../../services/sendData.dart';
import '../../../size_config.dart';
import '../../../utils/activites_type.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    // TODO: implement initState
    String userId = Provider.of<UserProvider>(context, listen: false).id.toString();
    SendData().getActivities({'consumer_id':userId,'from_id':"0"}, context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, provider, child) {
        List<ActivityModel> activities = provider.activites;
        return (provider.isLoading)
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            backButton(context),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                    style: headingBlack27,
                  ),
                  defaultSpace2x,
                  ...List.generate(
                    activities.length,
                        (index) => ListTile(
                      horizontalTitleGap: 0,
                      tileColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                          radius: getProportionateScreenWidth(40),
                          child: SvgPicture.asset(
                            alertType[activities[index].activity_type]['image'],
                            color: Colors.white,
                            width: getProportionateScreenWidth(30),
                          ),
                          backgroundColor: alertType[activities[index].activity_type]
                          ['color']),
                      title: Text(
                        activities[index].activity_title,
                        style: titleBlack20.copyWith(
                            color: alertType[activities[index].activity_type]['color'],
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${formatDateMMMd(activities[index].created_at)} at ${formatTime(activities[index].created_at)}'),
                    ),
                  ),
                  defaultSpace2x,
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
