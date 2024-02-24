import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';
import 'package:smart_bin/screens/login_page/sing_in_screen.dart';
import 'package:smart_bin/services/save_preference.dart';
import 'package:smart_bin/widgets/text.dart';

class OnboardingScreen extends StatefulWidget {
  static String routeName = "/onboarding_screen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  List<Slide> slides = [];
  Color skipColor = Colors.white;
  @override
  void initState() {
    super.initState();
    SettingProvider settingsProvider = Provider.of<SettingProvider>(this.context, listen: false);
    settingsProvider.setPrefrenceBool("firstTime", false);

    slides.add(
      Slide(
        widgetTitle: const HeadingWidget(
            text: "WIRELESS\n"
                "MONITORING OF\n"
                "TRASH EMPTYING"),
        heightImage: 270,
        widthImage: 270,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        pathImage: "assets/images/onboarding_1.png",
        backgroundColor: Color(0xff20AF91),
      ),
    );
    slides.add(
      Slide(
        heightImage: 300,
        widthImage: 300,
        widgetTitle: const HeadingWidget(
          text: "TRACKING OF DUSTBIN\nUSING IOT &\nMACHINE LEARNING",

        ),
        description: "Ye indulgence unreserved connection alteration appearance",
        pathImage: "assets/images/onboarding_2.png",
        backgroundColor: const Color(0xffFEAE4F),
      ),
    );
    slides.add(
      Slide(


        heightImage: 300,
        widthImage: 300,
        title: "RULER",
        widgetTitle: const HeadingWidget(text: "RECYCLE WASTE FOOD\nIN EFFICIENT WAY"),
        description: "Much evil soon high in hope do view. Out may few ",
        pathImage: "assets/images/onboarding_3.png",
        backgroundColor: const Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pushNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      hideStatusBar: true,
      renderSkipBtn: const Text(
        "SKIP",
        style: TextStyle(color:
        Colors.white
        ),
      ),
      renderNextBtn: Text(
        "NEXT",
        style: TextStyle(color: skipColor),
      ),
      loopAutoScroll: false,
      autoScroll: false,
      onDonePress: onDonePress,
    );
  }
}
