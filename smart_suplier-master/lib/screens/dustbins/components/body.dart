import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/models/dustbin_model.dart';
import 'package:smart_bin/provider/DustbinProvider.dart';
import 'package:smart_bin/screens/dustbins/components/dustbin_card.dart';
import 'package:smart_bin/services/sendData.dart';
import 'package:smart_bin/widgets/buttons.dart';
import 'package:smart_bin/widgets/text.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    SendData().getDustbinById(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        backButton(context),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Dustbins', style: headingBlack27),
        ),
        Consumer<DustbinProvider>(
          builder: (context, provider, child) {
            List<DustbinModel>dustbinList=provider.dustbins;
            return provider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: List.generate(
                        dustbinList.length, (index) => DustBinCard(dustbin: dustbinList[index])),
                  );
          },
        )
      ],
    );
  }
}
