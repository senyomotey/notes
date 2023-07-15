import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/main.dart';
import 'package:notes/routes/route_names.dart';
import 'package:notes/utilities/notify.dart';

import '../constants/colors.dart';
import '../models/note.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum NoteColor { red, orange, yellow, green, blue, indigo, white }

class AppStateProvider with ChangeNotifier {
  // variables and functions for home screen
  late List<Note> noteList;
  late Note note;

  navigateToSearchScreen({required BuildContext context}) {
    Navigator.pushNamed(context, RouteNames.searchScreenRoute);
  }

  navigateToEditorScreen({required BuildContext context}) {
    Navigator.pushNamed(context, RouteNames.editorScreenRoute);
  }

  fetchNotes() {
    // noteList = objectbox.getNotes();

    noteList = readNotesFirestore();

    notifyListeners();
  }

  deleteNote({required BuildContext context, required int id}) {
    Notify().showConfirmationDialog(
      context: context,
      message: AppLocalizations.of(context)!.delete_note_alert,
      positveAction: () {
        // delete note from db
        // objectbox.removeNote(id: id);
        deleteNoteFirestore(id: id);

        // remove note from note list
        noteList.removeWhere((element) => element.id == id);

        // if navigation was done from search screen, delete note from the search list
        if (searchList.isNotEmpty) {
          Note searchedNote = searchList.firstWhere((element) => element.id == id);

          if (searchedNote != null) {
            searchList.removeWhere((element) => element.id == id);
          }
        }

        noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        notifyListeners();

        Navigator.pop(context, true);
      },
    );
  }

  removeNote({required int id}) {
    // delete note from db
    // objectbox.removeNote(id: id);
    deleteNoteFirestore(id: id);

    // remove note from note list
    noteList.removeWhere((element) => element.id == id);

    // if navigation was done from search screen, delete note from the search list
    if (searchList.isNotEmpty) {
      Note searchedNote = searchList.firstWhere((element) => element.id == id);

      if (searchedNote != null) {
        searchList.removeWhere((element) => element.id == id);
      }
    }

    notifyListeners();
  }

  readNote({required BuildContext context}) {
    Navigator.pushNamed(context, RouteNames.readScreenRoute, arguments: {'note': note});
  }

  // variables and functions for reader screen
  openEditor({required BuildContext context, required Note note}) {
    Navigator.pushNamed(context, RouteNames.editorScreenRoute, arguments: {'note': note});
  }

  closeReader({required BuildContext context}) {
    Navigator.pop(context, true);
  }

  // variables and functions for search screen
  TextEditingController searchTextEditingController = TextEditingController();
  List<Note> searchList = [];
  bool noResults = false;

  searchNote() {
    if (searchTextEditingController.text.isNotEmpty) {
      searchList.clear();
      // searchList.addAll(objectbox.searchNotes(keyword: searchTextEditingController.text));
      searchList.addAll(noteList.where((element) =>
          element.title.toLowerCase().contains(searchTextEditingController.text.toLowerCase()) ||
          element.body.toLowerCase().contains(searchTextEditingController.text.toLowerCase())));

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

  saveNote({required BuildContext context, required Note note_}) async {
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
      positveAction: () async {
        // clear text fields
        titleTextEditingController.clear();
        bodyTextEditingController.clear();

        // save note in firebase
        createNoteFirestore(note_: note_);

        // add note to local db
        // objectbox.addNote(note: note_);

        if (noteList.isEmpty) {
          createNoteFirestore(note_: note_);
        } else {
          if (note_.id == note.id) {
            // remove note from note list if it exists
            noteList.removeWhere((element) => element.id == note_.id);

            // update note in firestore
            updateNoteFirestore(note_: note_);
          } else {
            // create note in firestore
            createNoteFirestore(note_: note_);
          }
        }

        // add note to note list
        noteList.add(note_);

        // update note object of this provider
        note = note_;

        // if navigation was done from search screen, update the search list
        if (searchList.isNotEmpty) {
          Note searchedNote = searchList.firstWhere((element) => element.id == note_.id);

          if (searchedNote != null) {
            searchList[searchList.indexWhere((element) => element.id == note_.id)] = note_;
          }
        }

        noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

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

  createNoteFirestore({required Note note_}) async {
    await firestore.collection('notes').doc(note_.id.toString()).set(note_.toJson());
  }

  List<Note> readNotesFirestore() {
    List<Note> noteList_ = [];

    firestore.collection('notes').get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        Note note_ = Note.fromJson(doc.data() as Map<String, dynamic>);
        noteList_.add(note_);
      }

      noteList = noteList_;

      notifyListeners();
    }).catchError((e) {
      log(e.toString());
    });

    return noteList_;
  }

  updateNoteFirestore({required Note note_}) async {
    await firestore.collection('notes').doc(note_.id.toString()).update(note_.toJson());
  }

  deleteNoteFirestore({required int id}) async {
    await firestore.collection('notes').doc(id.toString()).delete();
  }
}
