import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/friend.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/repositories.dart';
import 'package:xiaozheliao/screens/user/user_data_screen.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/user_photo.dart';

class SearchAddFriendInfo extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;
  final Friend _friend;
  final FocusNode _focusNode;

  SearchAddFriendInfo({
    Key key,
    @required UserRepository userRepository,
    @required User user,
    @required Friend friend,
    @required FocusNode focusNode,
  })  : assert(userRepository != null),
        assert(user != null),
        assert(friend != null),
        _userRepository = userRepository,
        _user = user,
        _friend = friend,
        _focusNode = focusNode,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 14.0),
        child: Row(
          children: <Widget>[
            UserPhoto(photo: _friend.user.photo, size: 44.0),
            SizedBox(width: 15.0),
            Text(
              _friend.user.nickname,
              style: TextStyle(
                fontSize: 18.0,
                color: XzlColors.ff333333,
              ),
            ),
          ],
        ),
      ),
      onTap: () => _viewUserData(context),
      onPanDown: (details) => _focusNode.unfocus(),
    );
  }

  Future<void> _viewUserData(BuildContext context) async {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => UserDataScreen(
          userRepository: _userRepository,
          friend: _friend,
          user: _user,
        ),
      ),
    );
  }
}
