import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:industry_app/constant.dart';
import 'package:industry_app/widgets/text.dart';

import '../../size_config.dart';

class WalletScreen extends StatelessWidget {
  static String routeName = "/wallet_screen";

  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Wallet', style: headingWhite27),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rs 200',
                    style: headingWhite27,
                  ),
                  Text(
                    'Available Balance',
                    style: titleWhite20,
                  ),
                  defaultSpace3x,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      width: SizeConfig.screenWidth * .60,
                      child: ListTile(
                        title: Text(
                          'Green Points',
                        ),
                        subtitle: Text(
                          '12000pt',
                          style: titleBlack20.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        leading: Container(
                          child: SvgPicture.asset(
                            'assets/icons/leaf.svg',
                          ),
                          width: SizeConfig.screenWidth * 0.11,
                          height: SizeConfig.screenWidth * 0.11,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green, borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            defaultSpace3x,
            defaultSpace2x,
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          35,
                        ),
                        topRight: Radius.circular(35))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction History',
                      style: titleBoldBlack20,
                    ),
                      ...List.generate(4, (index) =>
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6), color: Colors.white),
                            child: ListTile(
                              title: Text('12 Aug 2022'),
                              subtitle: Text('Order #12234'),
                              tileColor: Colors.white,
                              trailing: Text(
                                '+Rs 222',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),)
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
