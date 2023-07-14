import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  int id; // id of the note
  String uuid; // universal unique id ofthe note
  String title; // title of the note
  String body; // details of the note
  String color; // background color of the note
  String syncAction; // synchronization action to be performed
  bool
      syncStatus; // synchronization status. true means syncronzation was performed and is successful. false means otherwise
  DateTime createdAt; // date and time the note was created or modified

  Note({
    required this.id,
    required this.uuid,
    required this.title,
    required this.body,
    required this.color,
    required this.syncAction,
    required this.syncStatus,
    required this.createdAt,
  });
}
