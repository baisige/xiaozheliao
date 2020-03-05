import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FriendsProvider {
//  Database db;
//
//  Future open(String path) async {
//    db = await openDatabase(
//      path,
//      version: 1,
//      onCreate: (Database db, int version) async {
//        await db.execute('''
//        create table $tableMessage (
//        $columnId text primary key,
//        $columnContent text not null,
//        $columnSender text not null,
//        $columnSendDate text not null,
//        $columnReceiver text not null,
//        $columnCreateDate text,
//        $columnCancel integer,
//        $columnType integer,
//        $columnStatus integer,
//        $columnSoundsTime integer,
//        $columnFilename text,
//        $columnLength integer)
//        ''');
//      },
//    );
//  }
//
//  Future<Message> insert(Message message) async {
//    try {
//      await db.insert(tableMessage, message.toMap());
//      return message;
//    } catch (e) {
//      print(e);
//    }
//    return null;
//  }
//
//  Future<Message> getMessage(String id) async {
//    List<Map> maps = await db.query(tableMessage,
//        columns: [
//          columnId,
//          columnContent,
//          columnSender,
//          columnSendDate,
//          columnReceiver,
//          columnCreateDate,
//          columnCancel,
//          columnType,
//          columnStatus,
//          columnSoundsTime,
//          columnFilename,
//          columnLength,
//        ],
//        where: "$columnId = ?",
//        whereArgs: [id]);
//    if (maps.isNotEmpty) {
//      return Message.fromMap(maps.first);
//    }
//    return null;
//  }
//
//  Future<List<Message>> getPageMessage(
//      int limit, int offset, String sender, String recipient) async {
//    List<Map> maps = await db.query(
//      tableMessage,
//      columns: [
//        columnId,
//        columnContent,
//        columnSender,
//        columnSendDate,
//        columnReceiver,
//        columnCreateDate,
//        columnCancel,
//        columnType,
//        columnStatus,
//        columnSoundsTime,
//        columnFilename,
//        columnLength,
//      ],
//      where:
//          "($columnSender = ? and $columnReceiver = ?) or $columnSender = ? and $columnReceiver = ?",
//      whereArgs: [sender, recipient, recipient, sender],
//      orderBy: columnSendDate + ' DESC',
//      limit: limit,
//      offset: offset,
//    );
//    List<Message> messages = [];
//    if (maps.isNotEmpty) {
//      maps.forEach((item) => {messages.add(Message.fromMap(item))});
//      return messages;
//    }
//    return messages;
//  }
//
//  Future<List<Message>> getGroupPageMessage(
//      int limit, int offset, String groupId) async {
//    List<Map> maps = await db.query(
//      tableMessage,
//      columns: [
//        columnId,
//        columnContent,
//        columnSender,
//        columnSendDate,
//        columnReceiver,
//        columnCreateDate,
//        columnCancel,
//        columnType,
//        columnStatus,
//        columnSoundsTime,
//        columnFilename,
//        columnLength,
//      ],
//      where: "$columnReceiver = ?",
//      whereArgs: [groupId],
//      orderBy: columnSendDate + ' DESC',
//      limit: limit,
//      offset: offset,
//    );
//    List<Message> messages = [];
//    if (maps.isNotEmpty) {
//      maps.forEach((item) => {messages.add(Message.fromMap(item))});
//      return messages;
//    }
//    return messages;
//  }
//
//  Future<int> delete(String id) async {
//    return await db
//        .delete(tableMessage, where: "$columnId = ?", whereArgs: [id]);
//  }
//
//  Future<int> update(Message message) async {
//    return await db.update(tableMessage, message.toMap(),
//        where: "$columnId = ?", whereArgs: [message.id]);
//  }
//
//  Future<int> updateStatus(String id, int status, String createDate) async {
//    return await db.update(
//        tableMessage, {'status': status, 'createDate': createDate},
//        where: "$columnId = ?", whereArgs: [id]);
//  }
//
//  Future close() async => db.close();
}
