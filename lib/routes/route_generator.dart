import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/screens/editor/editor.dart';
import 'package:notes/screens/search/search.dart';

import '../constants/colors.dart';
import '../screens/home/home.dart';
import '../screens/launch/launch.dart';
import '../screens/onboarding/onboarding.dart';
import '../screens/pin/pin.dart';
import '../screens/reader/reader.dart';
import 'route_names.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouteGenerator {
  // Some classes(screens) have constructors with required named parameters.
  // The argument passing are defined here using the settings.arguments.
  // defaults are(and must be) set if no arguments are passed when Navigator.pushNamed is called
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // launch screen
      case RouteNames.launchScreenRoute:
        return CupertinoPageRoute(builder: (_) => const LaunchScreen());
      case RouteNames.onboardingScreenRoute:
        return CupertinoPageRoute(builder: (_) => const OnboardingScreen());

      // auth
      case RouteNames.pinScreenRoute:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;

        final mode = arguments['mode'];

        return CupertinoPageRoute(
          builder: (_) => PinScreen(mode: mode),
        );

      case RouteNames.homeScreenRoute:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());

      case RouteNames.searchScreenRoute:
        return CupertinoPageRoute(builder: (_) => const SearchScreen());

      case RouteNames.editorScreenRoute:
        if (settings.arguments != null) {
          final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;

          final note = arguments['note'];

          return CupertinoPageRoute(builder: (_) => EditorScreen(note: note));
        } else {
          return CupertinoPageRoute(builder: (_) => const EditorScreen());
        }
      case RouteNames.readScreenRoute:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;

        final note = arguments['note'];

        return CupertinoPageRoute(builder: (_) => ReaderScreen(note: note));
      default:
        // Goes it this screen if no route is found
        return CupertinoPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Center(
                        //   child: SvgPicture.asset('assets/images/empty_state_illustration.svg',
                        //       width: MediaQuery.of(context).size.shortestSide / 2,
                        //       semanticsLabel:
                        //           // "${AppLocalizations.of(context)?.error_screen_not_found}",
                        //           ""),
                        // ),
                        // const SizedBox(height: 80),
                        Center(
                          child: Text(
                            "${AppLocalizations.of(context)?.page_not_found}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Nunito',
                              textStyle:
                                  const TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.w600),
                            ),
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
