import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/good_friends.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/chat/message_repository.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_repository.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/chat/single_chat_screen.dart';
import 'package:xiaozheliao/screens/contacts/letter_searcher.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

import '../user_photo.dart';

class ContactsCollections extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;
  final ContactsRepository _contactsRepository;
  final ScrollController _controller;
  final Map<String, Set<GoodFriends>> _items;
  final MessageRepository _messageRepository;

  ContactsCollections({
    Key key,
    @required UserRepository userRepository,
    @required User user,
    @required ContactsRepository contactsRepository,
    @required ScrollController controller,
    @required Map<String, Set<GoodFriends>> items,
    @required MessageRepository messageRepository,
  })  : assert(userRepository != null),
        assert(user != null),
        assert(contactsRepository != null),
        assert(messageRepository != null),
        _userRepository = userRepository,
        _user = user,
        _contactsRepository = contactsRepository,
        _controller = controller,
        _items = items,
        _messageRepository = messageRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> friendsItems = [];
    final keys = _items.keys.toList();
    keys.sort();

    Widget otherContacts;
    for (String key in keys) {
      Set<GoodFriends> goodFriends = _items[key];
      List<Widget> items = [];
      for (int i = 0; i < goodFriends.length; i++) {
        GoodFriends element = goodFriends.elementAt(i);
        items.add(
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.only(
                left: 30.0,
                top: i == 0 ? 15.0 : 7.5,
                right: 30.0,
                bottom: i == goodFriends.length - 1 ? 15.0 : 7.5,
              ),
              child: Row(
                children: <Widget>[
                  UserPhoto(photo: element.photo, size: 44.0),
                  SizedBox(width: 15.0),
                  Text(
                    element.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: XzlColors.ff333333,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => _singleChatHappy(context, element),
          ),
        );
      }
      Widget contacts = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(key, style: TextStyle(color: XzlColors.ff666666)),
            ),
            ...items,
          ],
        ),
      );
      if (key == '#') {
        otherContacts = contacts;
      } else {
        friendsItems.add(contacts);
      }
    }

    if (otherContacts != null) {
      friendsItems.add(otherContacts);
    }

    return Stack(
      children: <Widget>[
        Scrollbar(
          child: ListView(
            controller: _controller,
            physics: BouncingScrollPhysics(),
            children: friendsItems,
          ),
        ),
        LetterSearcher(),
      ],
    );
  }

  void _singleChatHappy(BuildContext context, GoodFriends goodFriends) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => SingleChatScreen(
          userRepository: _userRepository,
          user: _user,
          contactsRepository: _contactsRepository,
          goodFriends: goodFriends,
          messageRepository: _messageRepository,
        ),
      ),
    );
  }
}
