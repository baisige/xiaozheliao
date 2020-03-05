import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xiaozheliao/blocs/user/user_bloc.dart';
import 'package:xiaozheliao/blocs/user/user_event.dart';
import 'package:xiaozheliao/blocs/user/user_state.dart';
import 'package:xiaozheliao/widgets/account/submit_button.dart';

class AddOrSendMessageButton extends StatelessWidget {
  final bool _isFriend;
  final String _applyUid;
  final String _userUid;

  AddOrSendMessageButton(
      {Key key, bool isFriend, String applyUid, String userUid})
      : assert(userUid != null),
        assert(applyUid != null),
        _isFriend = isFriend ?? false,
        _applyUid = applyUid,
        _userUid = userUid,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is AddingFriends) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: state.result ? '已申请加为好友' : '申请好友失败',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
          if (state.result) {
            await Future.delayed(Duration(milliseconds: 500));
            Fluttertoast.cancel();
            await Future.delayed(Duration(milliseconds: 500));
            Navigator.pop(context);
          }
        }
        if (state is FriendAddedError) {
          Fluttertoast.showToast(
            msg: '网络连接异常，请检查',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: SubmitButton(
              text: _isFriend ? '发送信息' : '加为好友',
              onPressed: () {
                UserBloc userBloc = BlocProvider.of<UserBloc>(context);
                _isFriend ? _sendMessage(userBloc) : _addFriend(userBloc);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addFriend(UserBloc userBloc) {
    userBloc.add(FriendsApplied(applyUid: _applyUid, userUid: _userUid));
  }

  void _sendMessage(UserBloc userBloc) {
    print('_sendMessage');
  }
}
