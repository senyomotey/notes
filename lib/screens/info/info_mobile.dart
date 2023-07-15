import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/action_bar_button.dart';

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // widget.note = objectbox.getNote(id: widget.note.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<AppStateProvider>(
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
                        icon: Icon(Icons.arrow_back, size: 24.0, color: actionBarItemIconColor),
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
