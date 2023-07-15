import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/providers/app_state_provider.dart';
import 'package:notes/widgets/action_bar_button.dart';
import 'package:notes/widgets/note_tile.dart';
import 'package:provider/provider.dart';
import '../../animations/delayed_display.dart';
import '../../constants/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreenTablet extends StatefulWidget {
  const HomeScreenTablet({Key? key}) : super(key: key);

  @override
  State<HomeScreenTablet> createState() => HomeScreenTabletState();
}

class HomeScreenTabletState extends State<HomeScreenTablet> with TickerProviderStateMixin {
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
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.app_title,
                          style: GoogleFonts.getFont(
                            'Nunito',
                            textStyle: TextStyle(
                              color: appTitleColor,
                              fontSize: 43.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      ActionBarButton(
                        icon: Icon(Icons.search, size: 24.0, color: actionBarItemIconColor),
                        onTap: () {
                          value.navigateToSearchScreen(context: context);
                        },
                      ),
                      const SizedBox(width: 20.0),
                      ActionBarButton(
                          icon: Icon(Icons.info, size: 24.0, color: actionBarItemIconColor),
                          onTap: () {
                            value.navigateToInfoScreen(context: context);
                          }),
                    ],
                  ),
                ),
                value.noteList.isNotEmpty
                    ? Expanded(
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 30.0),
                          scrollDirection: Axis.vertical,
                          itemCount: value.noteList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DelayedDisplay(
                              delay: Duration(milliseconds: 10 * index),
                              child: NoteTile(note: value.noteList[index]),
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/notes_empty.png', width: 330.0, height: 220.0),
                            const SizedBox(height: 15.0),
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.notes_empty,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Nunito',
                                    textStyle: TextStyle(
                                      color: appTitleColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: actionBarItemBackgroundColor,
            onPressed: () {
              value.navigateToEditorScreen(context: context);
            },
            child: const Icon(
              Icons.add,
              size: 35.0,
            ),
          ),
        );
      },
    );
  }
}
