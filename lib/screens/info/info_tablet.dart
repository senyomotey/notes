import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/action_bar_button.dart';

class InfoScreenTablet extends StatefulWidget {
  const InfoScreenTablet({Key? key}) : super(key: key);

  @override
  State<InfoScreenTablet> createState() => InfoScreenTabletState();
}

class InfoScreenTabletState extends State<InfoScreenTablet> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        value.note.title,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 48.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        value.note.body,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
