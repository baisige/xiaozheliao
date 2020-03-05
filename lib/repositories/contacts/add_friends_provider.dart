import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:xiaozheliao/models/add_friends.dart';

class AddFriendsProvider {
  Database db;

  AddFriendsProvider({Database db})
      : assert(db != null),
        this.db = db;

  Future<AddFriends> insert(AddFriends addFriends) async {
    try {
      await db.insert(tableAddFriends, addFriends.toMap());
      return addFriends;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<AddFriends> getNewFriends(String id) async {
    List<Map> maps = await db.query(tableAddFriends,
        columns: [
          columnId,
          columnApplyUid,
          columnVerifyContent,
          columnUserUid,
          columnStatus,
          columnApplyDate,
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return AddFriends.fromMap(maps.first);
    }
    return null;
  }

  Future<List<AddFriends>> getAddFriends(String userUid) async {
    List<Map> maps = await db.query(tableAddFriends,
        columns: [
          columnId,
          columnApplyUid,
          columnVerifyContent,
          columnUserUid,
          columnStatus,
          columnApplyDate,
        ],
        where: "$columnUserUid = ?",
        whereArgs: [userUid]);
    List<AddFriends> items = [];
    if (maps.isNotEmpty) {
      maps.forEach((item) => {items.add(AddFriends.fromMap(item))});
      return items;
    }
    return items;
  }

  Future<int> update(AddFriends addFriends) async {
    return await db.update(tableAddFriends, addFriends.toMap(),
        where: "$columnId = ?", whereArgs: [addFriends.id]);
  }

  Future<int> count(String id) async {
    List<Map> maps = await db.query(tableAddFriends,
        columns: ['COUNT(*)'], where: "$columnId = ?", whereArgs: [id]);
    return Sqflite.firstIntValue(maps);
  }

  Future close() async => db.close();
}
