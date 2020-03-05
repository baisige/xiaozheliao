import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:xiaozheliao/models/message.dart';

class MessageProvider {
  Database db;

  MessageProvider({Database db})
      : assert(db != null),
        this.db = db;

  Future<Message> insert(Message message) async {
    try {
      await db.insert(tableMessage, message.toMap());
      return message;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Message> getContacts(String id) async {
    List<Map> maps = await db.query(tableMessage,
        columns: [
          columnId,
          columnContent,
          columnSender,
          columnReceiver,
          columnCancel,
          columnHasRead,
          columnType,
          columnStatus,
          columnFilename,
          columnLength,
          columnSendDate,
          columnLastUpdate,
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Message.fromMap(maps.first);
    }
    return null;
  }

//  Future<List<Message>> getMessage(String myUid) async {
//    List<Map> maps = await db.query(tableMessage,
//        columns: [
//          columnId,
//          columnContent,
//          columnSender,
//          columnReceiver,
//          columnCancel,
//          columnHasRead,
//          columnType,
//          columnStatus,
//          columnFilename,
//          columnLength,
//          columnSendDate,
//          columnLastUpdate,
//        ],
//        where: "$columnMyUid = ?",
//        whereArgs: [myUid]);
//    List<Message> items = [];
//    if (maps.isNotEmpty) {
//      maps.forEach((item) => {items.add(Message.fromMap(item))});
//      return items;
//    }
//    return items;
//  }

  Future<List<Message>> getMessagePage(
      int limit, int offset, String sender, String receiver) async {
    List<Map> maps = await db.query(
      tableMessage,
      columns: [
        columnId,
        columnContent,
        columnSender,
        columnReceiver,
        columnCancel,
        columnHasRead,
        columnType,
        columnStatus,
        columnFilename,
        columnLength,
        columnSendDate,
        columnLastUpdate,
      ],
      where: '''($columnSender = ? and $columnReceiver = ?)
           or ($columnSender = ? and $columnReceiver = ?)''',
      whereArgs: [sender, receiver, receiver, sender],
      orderBy: columnSendDate + ' desc',
      limit: limit,
      offset: offset,
    );
    List<Message> messages = [];
    if (maps.isNotEmpty) {
      maps.forEach((item) => {messages.add(Message.fromMap(item))});
      return messages;
    }
    return messages;
  }

  Future<int> update(Message message) async {
    return await db.update(tableMessage, message.toMap(),
        where: "$columnId = ?", whereArgs: [message.id]);
  }

  Future<int> count(String id) async {
    List<Map> maps = await db.query(tableMessage,
        columns: ['COUNT(*)'], where: '$columnId = ?', whereArgs: [id]);
    return Sqflite.firstIntValue(maps);
  }

  Future<int> getGoodFriendsMessageCount(String sender, String receiver) async {
    List<Map> maps = await db.query(
      tableMessage,
      columns: ['COUNT(*)'],
      where: '''($columnSender = ? and $columnReceiver = ?)
           or ($columnSender = ? and $columnReceiver = ?)''',
      whereArgs: [sender, receiver, receiver, sender],
    );
    return Sqflite.firstIntValue(maps);
  }

  Future close() async => db.close();
}
