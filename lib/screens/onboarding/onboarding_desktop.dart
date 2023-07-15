import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreenDesktop extends StatefulWidget {
  const OnboardingScreenDesktop({Key? key}) : super(key: key);

  @override
  State<OnboardingScreenDesktop> createState() => OnboardingScreenDesktopState();
}

class OnboardingScreenDesktopState extends State<OnboardingScreenDesktop> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(),
    );
  }
}
