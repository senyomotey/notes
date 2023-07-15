import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

import '../../animations/delayed_display.dart';
import '../../constants/colors.dart';
import '../../models/onboarding_slide.dart';
import '../../routes/route_names.dart';
import '../../widgets/onboarding_dots.dart';

class OnboardingScreenDesktop extends StatefulWidget {
  const OnboardingScreenDesktop({Key? key}) : super(key: key);

  @override
  State<OnboardingScreenDesktop> createState() => OnboardingScreenDesktopState();
}

class OnboardingScreenDesktopState extends State<OnboardingScreenDesktop> with TickerProviderStateMixin {
  final PageController pageController = PageController(initialPage: 0);
  final List<OnboardingSlide> slideList = [
    OnboardingSlide(
      sliderImagePath: "assets/images/intuitive.svg",
      sliderHeading: "Intuitive note-taking",
      sliderSubHeading:
          "Effortlessly organize your thoughts and ideas by keeping your important information at your fingertips.",
    ),
    OnboardingSlide(
      sliderImagePath: "assets/images/productive.svg",
      sliderHeading: "Stay productive",
      sliderSubHeading: "Stay productive on the go by ensuring you never forget anything important or vital.",
    ),
    OnboardingSlide(
      sliderImagePath: "assets/images/peace.svg",
      sliderHeading: "Peace of mind",
      sliderSubHeading:
          "Experience peace of mind with our automatic cloud syncing, ensuring your notes are securely backed up and accessible.",
    ),
  ];
  int currentPage = 0;

  late Box userBox;

  @override
  void initState() {
    super.initState();

    userBox = Hive.box('user');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          top: deviceHeight * 0.05,
          left: deviceHeight * 0.02,
          right: deviceHeight * 0.02,
          bottom: deviceHeight * 0.04,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: finishFunction,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 233, 233, 233),
                    shape: const StadiumBorder(),
                    shadowColor: Colors.transparent),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: slideList.length,
              itemBuilder: (ctx, i) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 30),
                    child: SizedBox(
                      height: deviceWidth * 0.8,
                      width: deviceHeight * 0.6,
                      child: SvgPicture.asset(slideList[i].sliderImagePath),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 60),
                    child: Text(
                      slideList[i].sliderHeading,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 23.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 90),
                    child: Text(
                      slideList[i].sliderSubHeading,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      for (int i = 0; i < slideList.length; i++)
                        if (i == currentPage) const OnboardingDots(true) else const OnboardingDots(false)
                    ],
                  ),
                ),
              ),
              Row(children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(255, 233, 233, 233),
                    shape: CircleBorder(),
                  ),
                  child: IconButton.filled(
                    isSelected: true,
                    icon: const Icon(Icons.arrow_left),
                    iconSize: 35.0,
                    color: Colors.redAccent,
                    selectedIcon: const Icon(Icons.arrow_left),
                    onPressed: previousFuntion,
                  ),
                ),
                const SizedBox(width: 20.0),
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.redAccent,
                    shape: CircleBorder(),
                  ),
                  child: IconButton.filled(
                    isSelected: true,
                    icon: const Icon(Icons.arrow_right),
                    iconSize: 35.0,
                    color: Colors.white,
                    selectedIcon: const Icon(Icons.arrow_right),
                    onPressed: nextFuntion,
                  ),
                ),
              ]),
            ],
          )
        ]),
      ),
    );
  }

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  previousFuntion() {
    if (currentPage != 0 && currentPage < slideList.length + 1) {
      pageController.jumpToPage(currentPage - 1);
    }
  }

  nextFuntion() {
    if (currentPage < slideList.length - 1) {
      pageController.jumpToPage(currentPage + 1);
    } else {
      finishFunction();
    }
  }

  finishFunction() {
    userBox.put('appOpened', true);

    // Navigator.pushNamed(context, RouteNames.pinScreenRoute, arguments: {'mode': 'create'});

    Navigator.pushReplacementNamed(context, RouteNames.homeScreenRoute);
  }
}
