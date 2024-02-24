import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/provider/TransactionProvider.dart';
import 'package:smart_bin/provider/UserProvider.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/widgets/text.dart';

import '../../size_config.dart';
import '../models/transaction_model.dart';

class WalletScreen extends StatelessWidget {
  static String routeName = "/wallet_screen";

  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    SendData().getTransaction({'from_id':'0','producer_id':userProvider.id.toString()},context);
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
                    'Rs ${userProvider.walletBalance}',
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
                          '${userProvider.greenBalance}pt',
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
                child: Consumer<TransactionProvider>(builder: (context, provider, child) {
                  List<TransactionModel> transactions = provider.transactionModel;
                  return provider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction History',
                              style: titleBoldBlack20,
                            ),
                            ...List.generate(
                              transactions.length,
                              (index) => Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6), color: Colors.white),
                                child: ListTile(
                                  title: Text(transactions[index].txn_title),
                                  subtitle: Text(formatDateMMMd(transactions[index].created_at)),
                                  tileColor: Colors.white,
                                  trailing: Text(
                                    '+Rs ${transactions[index].txn_amount}',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
