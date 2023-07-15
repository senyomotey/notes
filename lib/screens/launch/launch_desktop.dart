import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:notes/constants/colors.dart';
import '../../routes/route_names.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LaunchScreenDesktop extends StatefulWidget {
  const LaunchScreenDesktop({Key? key}) : super(key: key);

  @override
  State<LaunchScreenDesktop> createState() => LaunchScreenDesktopState();
}

class LaunchScreenDesktopState extends State<LaunchScreenDesktop> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool _showColor = false;
  bool _showBall = false;
  bool _showLogo = false;

  late Box userBox;

  @override
  void initState() {
    super.initState();

    userBox = Hive.box('user');

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    )..addStatusListener(
        (AnimationStatus status) async {
          if (status == AnimationStatus.completed) {
            if (userBox.get('appOpened', defaultValue: false) == true) {
              // if (userBox.get('loggedIn') == true) {
              //   Navigator.pushNamed(context, RouteNames.pinScreenRoute, arguments: {'mode': 'login'});
              // } else {
              //   Navigator.pushNamed(context, RouteNames.pinScreenRoute, arguments: {'mode': 'create'});
              // }

              Navigator.pushReplacementNamed(context, RouteNames.homeScreenRoute);
            } else {
              Navigator.pushReplacementNamed(context, RouteNames.onboardingScreenRoute);
            }
          }
        },
      );

    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _showBall = true;
        _showColor = true;
      });
    });
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _showColor = false;
      });
    });
    Timer(const Duration(milliseconds: 1520), () {
      setState(() {
        _showLogo = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              backgroundColor,
              actionBarItemBackgroundColor,
            ],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 4000),
                curve: Curves.elasticOut,
                height: _showLogo
                    ? deviceHeight / 2.5
                    : _showBall
                        ? deviceHeight / 2
                        : 20,
              ),
              AnimatedContainer(
                duration: Duration(seconds: _showLogo ? 3 : 0),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _showLogo ? deviceHeight / 4 : 20,
                width: _showLogo ? deviceWidth : 20,
                decoration: BoxDecoration(
                  color: _showColor ? whiteNoteColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: SizeTransition(
                    sizeFactor: _animation,
                    axis: Axis.horizontal,
                    axisAlignment: 0,
                    child: Text(
                      AppLocalizations.of(context)!.app_title,
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: TextStyle(
                          color: appTitleColor,
                          fontSize: 53.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
