// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:notes/main.dart';
import 'package:notes/models/note.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  // Create a sample note
  Note note = Note(
      id: 0,
      uuid: const Uuid().v4(),
      userUuid: const Uuid().v4(),
      title: 'Test Note 1',
      body: 'This is a test note',
      color: 'yellow',
      syncAction: 'create',
      syncStatus: true,
      createdAt: DateTime.now());

  test('Save Note Test', () {
    // Call the function responsible for saving the note
    bool isNoteSaved = appStateProvider.createNoteFirestore(note_: note);

    // Verify that the note is saved successfully
    expect(isNoteSaved, true);
  });

  test('Read All Notes Test', () {
    // Create some sample notes
    List<Note> expectedNotes = [
      note,
    ];

    // Call the function responsible for reading all notes
    List<Note> actualNotes = appStateProvider.readNotesFirestore();

    // Verify that the actual notes match the expected notes
    expect(actualNotes, expectedNotes);
  });

  test('Update Note Test', () {
    note = Note(
        id: 0,
        uuid: note.uuid,
        userUuid: const Uuid().v4(),
        title: 'Test Note 2',
        body: 'This is another test note',
        color: 'green',
        syncAction: 'update',
        syncStatus: true,
        createdAt: DateTime.now());

    // Call the function responsible for updating the note
    bool isNoteUpdated = appStateProvider.updateNoteFirestore(note_: note);

    // Verify that the note is updated successfully
    expect(isNoteUpdated, true);
  });

  test('Delete Note Test', () {
    // Call the function responsible for deleting the note
    bool isNoteUpdated = appStateProvider.deleteNoteFirestore(uuid: note.uuid);

    // Verify that the note is updated successfully
    expect(isNoteUpdated, true);
  });
}
