import 'dart:developer';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/note.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<Note> noteBox;

  ObjectBox._create(this.store) {
    noteBox = Box<Note>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "Notes"));
    return ObjectBox._create(store);
  }

  List<Note> getNotes() {
    final builder = noteBox.query().order(Note_.createdAt, flags: Order.descending);

    final List<Note> results = builder.build().find();

    return results;
  }

  List<Note> searchNotes({required String keyword}) {
    final query = store
        .box<Note>()
        .query(
            Note_.title.contains(keyword, caseSensitive: false).or(Note_.body.contains(keyword, caseSensitive: false)))
        .build();

    final List<Note> results = query.find();

    return results;
  }

  Note getNote({required String uuid}) {
    final query = store.box<Note>().query(Note_.uuid.equals(uuid)).build();
    final List<Note> results = query.find();

    return results.first;
  }

  // Add a note
  Future<void> addNote({required Note note}) => noteBox.putAsync(note);

  // Delete a note
  Future<void> removeNote({required int id}) => noteBox.removeAsync(id);
}
