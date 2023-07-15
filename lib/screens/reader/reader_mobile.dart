import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/action_bar_button.dart';

// ignore: must_be_immutable
class ReaderScreenMobile extends StatefulWidget {
  // Note note;

  const ReaderScreenMobile({Key? key}) : super(key: key);

  @override
  State<ReaderScreenMobile> createState() => ReaderScreenMobileState();
}

class ReaderScreenMobileState extends State<ReaderScreenMobile> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // widget.note = objectbox.getNote(uuid: widget.note.uuid);
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
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 15.0),
                  child: Row(
                    children: [
                      ActionBarButton(
                        icon: Icon(Icons.arrow_back, size: 28.0, color: actionBarItemIconColor),
                        onTap: () {
                          value.closeReader(context: context);
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      ActionBarButton(
                        icon: Icon(Icons.delete, size: 28.0, color: whiteNoteColor),
                        onTap: () {
                          value.deleteNote(context: context, uuid: value.note.uuid);
                        },
                      ),
                      const SizedBox(width: 20.0),
                      ActionBarButton(
                        icon: Icon(Icons.edit, size: 28.0, color: whiteNoteColor),
                        onTap: () {
                          value.openEditor(context: context, note: value.note);
                        },
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
