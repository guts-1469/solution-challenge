import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../provider/UserProvider.dart';
import '../../../widgets/text.dart';
class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi ${userProvider.name},', style: titleBlack20),
        defaultSpace,
        Text(
          'Welcome Back !',
          style: headingBlack27,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/location.svg',
              width: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(userProvider.address,
              style: titleBlack18,
            ),

          ],
        ),
      ],
    );
  }
}
