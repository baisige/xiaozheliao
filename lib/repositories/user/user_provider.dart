import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:xiaozheliao/models/user.dart';

class UserProvider {
  final Database db;

  UserProvider({Database db})
      : assert(db != null),
        this.db = db;


  Future<User> insert(User user) async {
    try {
      await db.insert(tableUser, user.toMap());
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User> getUser(String uid) async {
    List<Map> maps = await db.query(tableUser,
        columns: [
          columnId,
          columnUid,
          columnUsername,
          columnNickname,
          columnMobile,
          columnPhoto,
          columnPosition,
          columnJobSeekState,
          columnSignature,
          columnSchool,
          columnGender,
          columnSkills,
          columnEnable,
          columnCreateDate,
        ],
        where: "$columnUid = ?",
        whereArgs: [uid]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getUsers() async {
    List<Map> maps = await db.query(
      tableUser,
      columns: [
        columnId,
        columnUid,
        columnUsername,
        columnNickname,
        columnMobile,
        columnPhoto,
        columnPosition,
        columnJobSeekState,
        columnSignature,
        columnSchool,
        columnGender,
        columnSkills,
        columnEnable,
        columnCreateDate,
      ],
    );
    List<User> items = [];
    if (maps.isNotEmpty) {
      maps.forEach((item) => {items.add(User.fromMap(item))});
      return items;
    }
    return items;
  }

  Future<int> update(User user) async {
    return await db.update(tableUser, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

  Future<int> count(int id) async {
    List<Map> maps = await db.query(tableUser,
        columns: ['COUNT(*)'], where: "$columnId = ?", whereArgs: [id]);
    return Sqflite.firstIntValue(maps);
  }

  Future close() async => db.close();
}
