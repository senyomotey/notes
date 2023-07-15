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
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: Container(),
    );
  }
}
