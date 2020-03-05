import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/friend.dart';

import '../user_photo.dart';

class MainData extends StatelessWidget {
  final Friend _friend;

  MainData({Key key, @required Friend friend})
      : assert(friend != null),
        _friend = friend,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 14.0),
      child: Row(
        children: <Widget>[
          UserPhoto(photo: _friend.user.photo, size: 75.0),
          SizedBox(width: 14.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    _friend.user.nickname,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 3.0),
                    child: Image.asset(
                        _friend.user.gender == '女'
                            ? 'assets/images/user/boy.png'
                            : 'assets/images/user/girl.png',
                        height: 20.0),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                '账号：${_friend.user.uid}',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
