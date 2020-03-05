import 'dart:convert';

import 'package:xiaozheliao/models/user.dart';

class Friend {
  User user;
  bool isFriend;

  Friend.fromMap(Map map) {
    user = User.fromMap(map['user']);
    isFriend = map['isFriend'] as bool;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'isFriend': isFriend,
    };
  }

  @override
  String toString() => jsonEncode(this.toMap());
}
