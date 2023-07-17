import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/user_state_provider.dart';
import '../../widgets/action_bar_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class InfoScreenMobile extends StatefulWidget {
  const InfoScreenMobile({Key? key}) : super(key: key);

  @override
  State<InfoScreenMobile> createState() => InfoScreenMobileState();
}

class InfoScreenMobileState extends State<InfoScreenMobile> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<UserStateProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            height: deviceHeight,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 15.0),
                  child: Row(
                    children: [
                      ActionBarButton(
                        icon: Icon(Icons.arrow_back, size: 28.0, color: actionBarItemIconColor),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Made by Senyo Motey',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Designed by Senyo Motey',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Icons - PNG and SVG',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Font - Nunito',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: positiveButtonColor,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                    ),
                    onPressed: () {
                      value.signOut(context: context);
                    },
                    child: Container(
                      height: 55.0,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.signout,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: TextStyle(color: negativeButtonColor, fontSize: 23.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Version 1.0.0',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Nunito',
                      textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
