import 'dart:convert';

import 'package:intl/intl.dart';

final String tableAddFriends = "AddFriends";

final String columnId = "id";
final String columnApplyUid = "applyUid";
final String columnUserUid = "userUid";
final String columnStatus = "status";
final String columnVerifyContent = "verifyContent";
final String columnApplyDate = "applyDate";

String get createAddFriendsTable => '''
        create table $tableAddFriends (
        $columnId text primary key, 
        $columnApplyUid text not null,
        $columnVerifyContent text,
        $columnUserUid text not null,
        $columnStatus integer,
        $columnApplyDate text)
        ''';

class AddFriends {
  String id;
  String applyUid;
  String verifyContent;
  String userUid;
  int status;
  String applyDate;

  AddFriends.fromMap(Map map) {
    id = map[columnId] as String;
    applyUid = map[columnApplyUid] as String;
    verifyContent = map[columnVerifyContent] as String;
    userUid = map[columnUserUid] as String;
    status = map[columnStatus] as int;
    DateTime dateTime = DateTime.parse(map[columnApplyDate]) ;
    applyDate =  DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: id,
      columnApplyUid: applyUid,
      columnVerifyContent: verifyContent,
      columnUserUid: userUid,
      columnStatus: status,
      columnApplyDate: applyDate,
    };
  }

  @override
  String toString() => jsonEncode(this.toMap());
}
