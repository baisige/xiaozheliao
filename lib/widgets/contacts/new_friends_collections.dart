import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/contacts/bloc.dart';
import 'package:xiaozheliao/blocs/contacts/contacts_bloc.dart';
import 'package:xiaozheliao/models/add_friends.dart';
import 'package:xiaozheliao/models/new_friends.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/user_photo.dart';

class NewFriendsCollections extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;
  final List<NewFriends> _items;

  NewFriendsCollections({
    Key key,
    @required UserRepository userRepository,
    @required User user,
    @required List<NewFriends> items,
  })  : assert(userRepository != null),
        assert(user != null),
        assert(items != null),
        _userRepository = userRepository,
        _user = user,
        _items = items,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsBloc contactsBloc = BlocProvider.of<ContactsBloc>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: _buildNewFriendsContent(contactsBloc),
      ),
    );
  }

  List<Widget> _buildNewFriendsContent(ContactsBloc contactsBloc) {
    List<Widget> children = [];
    for (int i = 0; i < _items.length; i++) {
      AddFriends addFriends = _items[i].addFriends;
      int status = addFriends.status;
      Widget applyStatus;
      if (status == 1) {
        applyStatus = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 66.0,
                height: 26.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: XzlColors.ff999999),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text('拒绝', style: TextStyle(color: XzlColors.ff666666)),
              ),
              onTap: () => _handleNewFriendsApply(contactsBloc, addFriends, 2),
            ),
            SizedBox(width: 15.0),
            GestureDetector(
              child: Container(
                width: 66.0,
                height: 26.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: XzlColors.ff53cac3,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text('同意', style: TextStyle(color: Colors.white)),
              ),
              onTap: () => _handleNewFriendsApply(contactsBloc, addFriends, 3),
            ),
          ],
        );
      } else {
        String data = '';
        if (status == 2) {
          data = '已拒绝';
        }
        if (status == 3) {
          data = '已同意';
        }
        applyStatus = Text(
          data,
          textAlign: TextAlign.end,
          style: TextStyle(color: XzlColors.ff999999),
        );
      }

      children.add(
        Container(
          padding: EdgeInsets.only(top: i == 0 ? 0 : 14.0, bottom: 14.0),
          child: Row(
            children: <Widget>[
              UserPhoto(photo: _items[i].photo, size: 44.0),
              SizedBox(width: 14.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_items[i].name,
                      style:
                          TextStyle(fontSize: 16.0, color: XzlColors.ff333333)),
                  Text('申请添加好友', style: TextStyle(color: XzlColors.ff666666)),
                ],
              ),
              Expanded(child: applyStatus),
            ],
          ),
        ),
      );
    }
    return children;
  }

  void _handleNewFriendsApply(
      ContactsBloc contactsBloc, AddFriends addFriends, int status) {
    addFriends = AddFriends.fromMap(addFriends.toMap());
    addFriends..status = status;
    contactsBloc.add(NewFriendsHandled(addFriends: addFriends));
  }
}
