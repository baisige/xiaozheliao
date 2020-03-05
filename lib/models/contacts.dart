import 'dart:convert';

import 'package:intl/intl.dart';

final String tableContacts = "Contacts";

final String columnId = "id";
final String columnMyUid = "myUid";
final String columnUserUid = "userUid";
final String columnNoteName = "noteName";
final String columnLink = "link";
final String columnCreateDate = "createDate";

String get createContactsTable => '''
        create table $tableContacts (
        $columnId text primary key, 
        $columnMyUid text not null,
        $columnUserUid text not null,
        $columnNoteName text,
        $columnLink integer,
        $columnCreateDate text)
        ''';

class Contacts {
  String id;
  String myUid;
  String userUid;
  String noteName;
  bool link;
  String createDate;

  Contacts.fromMap(Map map) {
    id = map[columnId] as String;
    myUid = map[columnMyUid] as String;
    userUid = map[columnUserUid] as String;
    noteName = map[columnNoteName] as String;
    link = map[columnLink] == 1;
    DateTime dateTime = DateTime.parse(map[columnCreateDate]);
    createDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: id,
      columnMyUid: myUid,
      columnUserUid: userUid,
      columnNoteName: noteName,
      columnLink: link,
      columnCreateDate: createDate,
    };
  }

  @override
  String toString() => jsonEncode(this.toMap());
}
