import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xiaozheliao/models/add_friends.dart';
import 'package:xiaozheliao/models/contacts.dart';
import 'package:xiaozheliao/models/message.dart';
import 'package:xiaozheliao/models/user.dart';

Future<String> initDb() async {
  final String databasePath = await getDatabasesPath();
  final String path = join(databasePath, 'xiaozheliao.db');

  if (!await Directory(dirname(path)).exists()) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
  }
  return path;
}

Future<Database> open() async {
  Database db = await openDatabase(
    await initDb(),
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(createUserTable);
      await db.execute(createAddFriendsTable);
      await db.execute(createContactsTable);
      await db.execute(createMessageTable);
    },
//    onUpgrade:  (Database db, int version) async {
//      await db.execute(createUserTable);
//      await db.execute(createAddFriendsTable);
//      await db.execute(createContactsTable);
//      await db.execute(createMessageTable);
//    },
  );
  return db;
}
