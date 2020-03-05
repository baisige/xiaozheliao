import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/user/bloc.dart';
import 'package:xiaozheliao/models/friend.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/repositories.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/custom_app_bar.dart';
import 'package:xiaozheliao/widgets/user/add_or_send_message.dart';
import 'package:xiaozheliao/widgets/user/main_data.dart';

class UserDataScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final Friend _friend;
  final User _user;
  final Map<String, String> items = {
    'position': '职位',
    'signature': '奋斗目标',
    'jobSeekState': '求职状态',
    'school': '毕业院校',
    'skills': '专业及技能',
  };

  UserDataScreen({
    Key key,
    @required UserRepository userRepository,
    @required Friend friend,
    @required User user,
  })  : assert(userRepository != null),
        assert(friend != null),
        assert(User != null),
        _userRepository = userRepository,
        _friend = friend,
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChildCustomAppBar(context, '个人资料', null, null),
      body: BlocProvider<UserBloc>(
        create: (context) => UserBloc(userRepository: _userRepository),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    MainData(friend: _friend),
                    ..._mapFriendToExtData(),
                  ],
                ),
                AddOrSendMessageButton(
                  isFriend: _friend.isFriend,
                  userUid: _friend.user.uid,
                  applyUid: _user.uid,
                ),
                Container(),
              ],
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is AddFriendsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _mapFriendToExtData() {
    var iterator = items.entries.iterator;
    var user = _friend.user.toMap();

    int counter = 0;
    List<Widget> extData = [];
    while (iterator.moveNext()) {
      extData.add(
        Container(
          padding: EdgeInsets.only(
            left: 14.0,
            top: counter == 0 ? 0 : 15.0,
            right: 14.0,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    iterator.current.value,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    user[iterator.current.key] ?? '未填写',
                    style: TextStyle(color: XzlColors.ff999999),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Divider(height: 1.0),
            ],
          ),
        ),
      );
      counter++;
    }
    return extData;
  }
}
