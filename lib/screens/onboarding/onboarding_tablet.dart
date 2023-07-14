import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreenTablet extends StatefulWidget {
  const OnboardingScreenTablet({Key? key}) : super(key: key);

  @override
  State<OnboardingScreenTablet> createState() => OnboardingScreenTabletState();
}

class OnboardingScreenTabletState extends State<OnboardingScreenTablet> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(),
    );
  }
}
