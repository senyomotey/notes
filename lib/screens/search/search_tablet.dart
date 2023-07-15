import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../main.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/note_tile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreenTablet extends StatefulWidget {
  const SearchScreenTablet({Key? key}) : super(key: key);

  @override
  State<SearchScreenTablet> createState() => SearchScreenTabletState();
}

class SearchScreenTabletState extends State<SearchScreenTablet> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    appStateProvider.noResults = false;
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
                  child: Container(
                    padding: const EdgeInsets.only(top: 3.0, right: 8.0, left: 5.0, bottom: 3.0),
                    decoration: BoxDecoration(
                      color: actionBarItemBackgroundColor,
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: TextField(
                      controller: value.searchTextEditingController,
                      maxLines: 1,
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
                      ),
                      onChanged: (value_) {
                        value.searchNote();
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.search_hint,
                        hintStyle: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: TextStyle(color: textHintColor, fontSize: 20.0, fontWeight: FontWeight.w300),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            value.closeSearch(context: context);
                          },
                          child: Icon(Icons.arrow_back, color: actionBarItemIconColor),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            value.clearSearchTextField(context: context);
                          },
                          child: Icon(Icons.close, color: actionBarItemIconColor),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                !value.noResults
                    ? Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: value.searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NoteTile(note: value.searchList[index]);
                          },
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/search_empty.png', width: 330.0, height: 220.0),
                            const SizedBox(height: 15.0),
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.search_empty,
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
        );
      },
    );
  }
}
