import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/contacts/add_friends_screen.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/home/app_bar_more.dart';

class NoticesScreen extends StatefulWidget {
  final bool _isMore;
  final VoidCallback _closeMoreBar;
  final UserRepository _userRepository;
  final User _user;

  NoticesScreen({
    Key key,
    @required UserRepository userRepository,
    bool isMore = false,
    VoidCallback closeMoreBar,
    User user,
  })  : assert(userRepository != null),
        assert(user != null),
        _userRepository = userRepository,
        _isMore = isMore,
        _closeMoreBar = closeMoreBar,
        _user = user,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoticesScreenState();
  }
}

class NoticesScreenState extends State<NoticesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/notices/invite-bg.png'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '朋友一起聊才开心',
                          style: TextStyle(color: XzlColors.ff666666),
                        ),
                        SizedBox(width: 16.0),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 76.0,
                            height: 26.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: XzlColors.ff53cac3,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              '立即邀请',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {},
                        ),
                        SizedBox(width: 16.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPanDown: (details) => widget._closeMoreBar(),
        ),
        AppBarMore(
          isMore: widget._isMore,
          onTap: (index) {
            widget._closeMoreBar();
            if (index == 2) {
              Navigator.of(context).push(
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => AddFriendsScreen(
                    userRepository: widget._userRepository,
                    user: widget._user,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
