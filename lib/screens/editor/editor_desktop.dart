import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../constants/colors.dart';
import '../../main.dart';
import '../../models/note.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/action_bar_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditorScreenDesktop extends StatefulWidget {
  final Note? note;

  const EditorScreenDesktop({Key? key, this.note}) : super(key: key);

  @override
  State<EditorScreenDesktop> createState() => EditorScreenDesktopState();
}

class EditorScreenDesktopState extends State<EditorScreenDesktop> with TickerProviderStateMixin {
  late Note _note;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _note = widget.note!;
    } else {
      _note = Note(
        id: 0,
        uuid: const Uuid().v4(),
        title: '',
        body: '',
        color: NoteColor.yellow.name,
        syncAction: 'add',
        syncStatus: false,
        createdAt: DateTime.now(),
      );
    }

    appStateProvider.titleTextEditingController.text = _note.title;
    appStateProvider.bodyTextEditingController.text = _note.body;
    appStateProvider.noteColor = NoteColor.values.firstWhere((e) => e.name == _note.color);
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
                          value.closeEditor(context: context, note: _note);
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Consumer<AppStateProvider>(
                        builder: (context, value, child) {
                          return ActionBarButton(
                            icon: Icon(Icons.circle,
                                size: 24.0,
                                color: value.noteColor == NoteColor.red
                                    ? redNoteColor
                                    : value.noteColor == NoteColor.orange
                                        ? orangeNoteColor
                                        : value.noteColor == NoteColor.yellow
                                            ? yellowNoteColor
                                            : value.noteColor == NoteColor.green
                                                ? greenNoteColor
                                                : value.noteColor == NoteColor.blue
                                                    ? blueNoteColor
                                                    : value.noteColor == NoteColor.indigo
                                                        ? indigoNoteColor
                                                        : value.noteColor == NoteColor.white
                                                            ? whiteNoteColor
                                                            : yellowNoteColor),
                            onTap: () {
                              value.pickNoteColor(context: context);
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 20.0),
                      ActionBarButton(
                        icon: Icon(Icons.save, size: 28.0, color: actionBarItemIconColor),
                        onTap: () {
                          _note.title = value.titleTextEditingController.text;
                          _note.body = value.bodyTextEditingController.text;
                          _note.color = value.noteColor.name;
                          _note.createdAt = DateTime.now();

                          value.saveNote(context: context, note_: _note);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: value.titleTextEditingController,
                        minLines: 1,
                        maxLines: 3,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 48.0, fontWeight: FontWeight.w400),
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.title_hint,
                          hintStyle: GoogleFonts.getFont(
                            'Nunito',
                            textStyle: TextStyle(color: textHintColor, fontSize: 48.0, fontWeight: FontWeight.w400),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      TextField(
                        controller: value.bodyTextEditingController,
                        minLines: 1,
                        maxLines: 100,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.body_hint,
                          hintStyle: GoogleFonts.getFont(
                            'Nunito',
                            textStyle: TextStyle(color: textHintColor, fontSize: 23.0, fontWeight: FontWeight.w400),
                          ),
                          border: InputBorder.none,
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
