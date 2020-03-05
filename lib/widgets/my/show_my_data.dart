import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/user_photo.dart';

class ShowMyData extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;

  ShowMyData({
    Key key,
    @required UserRepository userRepository,
    @required User user,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Image.asset('assets/images/my/personal-bg.png'),
        Positioned(
          top: 20.0,
          right: 20.0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: ImageIcon(
              AssetImage('assets/images/my/edit-data.png'),
              size: 16.0,
              color: XzlColors.ff666666,
            ),
            onTap: () {
              print('1');
            },
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            UserPhoto(photo: _user.photo, size: 60.0),
            Container(
              padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _user.nickname,
                    style: TextStyle(
                      color: XzlColors.ff333333,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: ImageIcon(
                      AssetImage('assets/images/my/qrcode.png'),
                      size: 14.0,
                      color: XzlColors.ff333333,
                    ),
                    onTap: () {
                      print('2');
                    },
                  ),
                ],
              ),
            ),
            Text(
              _user.signature ?? '未填写',
              style: TextStyle(
                color: XzlColors.ff666666,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
