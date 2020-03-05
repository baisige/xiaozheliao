import 'dart:convert';

import 'package:xiaozheliao/models/add_friends.dart';

class NewFriends {
  String name;
  String photo;
  AddFriends addFriends;

  NewFriends.fromMap(Map map) {
    name = map['name'] as String;
    photo = map['photo'] as String;
    addFriends = map['addFriends'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photo': photo,
      'addFriends': addFriends,
    };
  }

  @override
  String toString() => jsonEncode(this.toMap());
}
