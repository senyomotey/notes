import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/launch/launch.dart';
import '../screens/onboarding/onboarding.dart';
import 'route_names.dart';

class RouteGenerator {
  ///Some classes(screens) have constructors with required named parameters.
  ///The argument passing are defined here using the settings.arguments.
  ///defaults are(and must be) set if no arguments are passed when Navigator.pushNamed is called
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // launch screen
      case RouteNames.launchScreenRoute:
        return CupertinoPageRoute(builder: (_) => const LaunchScreen());

      case RouteNames.onboardingScreenRoute:
        return CupertinoPageRoute(builder: (_) => const OnboardingScreen());

      // // login
      // case RouteNames.loginScreenRoute:
      //   return CupertinoPageRoute(
      //     builder: (_) => const LoginScreen(),
      //   );

      // // sign up
      // case RouteNames.signUpScreenRoute:
      //   return CupertinoPageRoute(
      //     builder: (_) => const SignUpScreen(),
      //   );

      default:
        //Goes it this screen if no route is found
        return CupertinoPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset('assets/images/empty_state_illustration.svg',
                              width: MediaQuery.of(context).size.shortestSide / 2,
                              semanticsLabel:
                                  // "${AppLocalizations.of(context)?.error_screen_not_found}",
                                  ""),
                        ),
                        const SizedBox(height: 80),
                        Center(
                          child: Text(
                            // "${AppLocalizations.of(context)?.error_screen_not_found}",
                            "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }
  }
}
