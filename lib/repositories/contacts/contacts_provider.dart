import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:xiaozheliao/models/contacts.dart';

class ContactsProvider {
  Database db;

  ContactsProvider({Database db})
      : assert(db != null),
        this.db = db;

  Future<Contacts> insert(Contacts contacts) async {
    try {
      await db.insert(tableContacts, contacts.toMap());
      return contacts;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Contacts> getContacts(String id) async {
    List<Map> maps = await db.query(tableContacts,
        columns: [
          columnId,
          columnMyUid,
          columnUserUid,
          columnLink,
          columnCreateDate,
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contacts.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Contacts>> getMyContacts(String myUid) async {
    List<Map> maps = await db.query(tableContacts,
        columns: [
          columnId,
          columnMyUid,
          columnUserUid,
          columnLink,
          columnCreateDate,
        ],
        where: "$columnMyUid = ?",
        whereArgs: [myUid]);
    List<Contacts> items = [];
    if (maps.isNotEmpty) {
      maps.forEach((item) => {items.add(Contacts.fromMap(item))});
      return items;
    }
    return items;
  }

  Future<int> update(Contacts contacts) async {
    return await db.update(tableContacts, contacts.toMap(),
        where: "$columnId = ?", whereArgs: [contacts.id]);
  }

  Future<int> count(String id) async {
    List<Map> maps = await db.query(tableContacts,
        columns: ['COUNT(*)'], where: "$columnId = ?", whereArgs: [id]);
    return Sqflite.firstIntValue(maps);
  }

  Future close() async => db.close();
}
