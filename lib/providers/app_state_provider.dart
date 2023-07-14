import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/main.dart';
import 'package:notes/routes/route_names.dart';
import 'package:notes/utilities/notify.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/note.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum NoteColor { red, orange, yellow, green, blue, indigo, white }

class AppStateProvider with ChangeNotifier {
  // variables and functions for home screen
  List<Note> noteList = objectbox.getNotes();

  navigateToSearchScreen({required BuildContext context}) {
    Navigator.pushNamed(context, RouteNames.searchScreenRoute);
  }

  navigateToEditorScreen({required BuildContext context}) {
    Navigator.pushNamed(context, RouteNames.editorScreenRoute);
  }

  fetchNotes() {
    noteList = objectbox.getNotes();

    notifyListeners();
  }

  deleteNote({required BuildContext context, required int id}) {
    Notify().showConfirmationDialog(
      context: context,
      message: AppLocalizations.of(context)!.delete_note_alert,
      positveAction: () {
        objectbox.removeNote(id: id);

        noteList.removeWhere((element) => element.id == id);

        notifyListeners();

        Navigator.pop(context, true);
      },
    );
  }

  readNote({required BuildContext context, required Note note}) {
    Navigator.pushNamed(context, RouteNames.readScreenRoute, arguments: {'note': note});
  }

  // variables and functions for reader screen
  openEditor({required BuildContext context, required Note note}) {
    Navigator.pushNamed(context, RouteNames.editorScreenRoute, arguments: {'note': note});
  }

  closeReader({required BuildContext context}) {
    noteList = objectbox.getNotes();

    notifyListeners();

    Navigator.pop(context, true);

    notifyListeners();
  }

  // variables and functions for search screen
  TextEditingController searchTextEditingController = TextEditingController();
  List<Note> searchList = [];
  bool noResults = false;

  searchNote() {
    if (searchTextEditingController.text.isNotEmpty) {
      searchList = objectbox.searchNotes(keyword: searchTextEditingController.text);

      if (searchList.isEmpty) {
        noResults = true;
      } else {
        noResults = false;
      }
    } else {
      searchList.clear();

      noResults = false;
    }

    notifyListeners();
  }

  clearSearchTextField({required BuildContext context}) {
    noResults = false;
    searchTextEditingController.clear();

    notifyListeners();
  }

  closeSearch({required BuildContext context}) {
    noResults = false;
    searchList.clear();
    searchTextEditingController.clear();

    notifyListeners();

    Navigator.pop(context);
  }

  // variables and functions for editor screen
  NoteColor noteColor = NoteColor.yellow;
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController bodyTextEditingController = TextEditingController();

  Color getNoteColor({required NoteColor noteColor}) {
    switch (noteColor) {
      case NoteColor.red:
        return redNoteColor;
      case NoteColor.orange:
        return orangeNoteColor;
      case NoteColor.yellow:
        return yellowNoteColor;
      case NoteColor.green:
        return greenNoteColor;
      case NoteColor.blue:
        return blueNoteColor;
      case NoteColor.indigo:
        return indigoNoteColor;
      case NoteColor.white:
        return whiteNoteColor;
      default:
        return yellowNoteColor;
    }
  }

  pickNoteColor({required BuildContext context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 30.0),
          actionsPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          title: Text(
            'Pick a color',
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              'Nunito',
              textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.red;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: redNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.red,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.orange;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: orangeNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.orange,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.yellow;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: yellowNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.yellow,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.green;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: greenNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.green,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.blue;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: blueNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.blue,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.indigo;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: indigoNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.indigo,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    noteColor = NoteColor.white;

                    Navigator.pop(context);

                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 24.0, color: whiteNoteColor),
                      const SizedBox(width: 15.0),
                      Text(
                        AppLocalizations.of(context)!.white,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      )
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

  saveNote({required BuildContext context, required Note note}) async {
    if (titleTextEditingController.text.isEmpty) {
      Notify().showSnackBar(
          message: AppLocalizations.of(context)!.alert_empty_title, color: errorSnackbarColor, context: context);

      return;
    }

    if (bodyTextEditingController.text.isEmpty) {
      Notify().showSnackBar(
          message: AppLocalizations.of(context)!.alert_empty_body, color: errorSnackbarColor, context: context);

      return;
    }

    Notify().showConfirmationDialog(
      context: context,
      message: AppLocalizations.of(context)!.save_note_alert,
      positveAction: () {
        titleTextEditingController.clear();
        bodyTextEditingController.clear();

        objectbox.addNote(note: note);

        noteList.add(note);

        notifyListeners();

        Navigator.pop(context, true);
      },
    );
  }

  closeEditor({required BuildContext context, required Note note}) {
    if (titleTextEditingController.text != note.title || bodyTextEditingController.text != note.body) {
      Notify().showConfirmationDialog(
          context: context,
          message: AppLocalizations.of(context)!.unsaved_note_alert,
          positveAction: () {
            titleTextEditingController.clear();
            bodyTextEditingController.clear();

            notifyListeners();

            Navigator.pop(context);
          });
    } else {
      Navigator.pop(context);
    }
  }
}
