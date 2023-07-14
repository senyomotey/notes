import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../../routes/route_names.dart';

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
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(),
    );
  }
}
