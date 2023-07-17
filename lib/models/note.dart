import 'package:intl/intl.dart';

class Note {
  int id; // id of the note
  String uuid; // universal unique id of the note
  String userUuid; // universal unique id of the user
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
    required this.userUuid,
    required this.title,
    required this.body,
    required this.color,
    required this.syncAction,
    required this.syncStatus,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      title: json['title'],
      body: json['body'],
      color: json['color'],
      syncAction: json['syncAction'],
      syncStatus: json['syncStatus'],
      createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "uuid": uuid,
        "userUuid": userUuid,
        "title": title,
        "body": body,
        "color": color,
        "syncAction": syncAction,
        "syncStatus": syncStatus,
        "createdAt": createdAt.toString(),
      };
}
