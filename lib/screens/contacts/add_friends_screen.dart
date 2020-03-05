import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/search/searcher_screen.dart';
import 'package:xiaozheliao/screens/search/searcher.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/contacts/friends_actions.dart';
import 'package:xiaozheliao/widgets/custom_app_bar.dart';

class AddFriendsScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;

  AddFriendsScreen(
      {Key key, @required UserRepository userRepository, @required User user})
      : assert(userRepository != null),
        assert(user != null),
        _userRepository = userRepository,
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChildCustomAppBar(context, '添加好友', null, null),
      body: Column(
        children: <Widget>[
          Container(
            height: 34.0,
            margin: EdgeInsets.only(left: 12.0, top: 20.0, right: 12.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: XzlColors.ffeeeeee,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: <Widget>[
                  ImageIcon(
                    AssetImage('assets/images/common/icons/bar/search.png'),
                    color: XzlColors.ff999999,
                    size: 18.0,
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    '搜索',
                    style: TextStyle(
                      color: XzlColors.ff999999,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SearcherScreen(
                      userRepository: _userRepository,
                      searchType: SearchType.ADD_FRIENDS,
                      user: _user,
                    ),
                  ),
                );
              },
            ),
          ),
          FriendsActions(
            onTap: (index) {
              print(index);
            },
          ),
        ],
      ),
    );
  }
}
