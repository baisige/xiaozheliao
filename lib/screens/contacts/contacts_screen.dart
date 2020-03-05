import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/contacts/bloc.dart';
import 'package:xiaozheliao/models/contacts.dart';
import 'package:xiaozheliao/models/good_friends.dart';
import 'package:xiaozheliao/models/new_friends.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/chat/message_repository.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_repository.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/contacts/add_friends_screen.dart';
import 'package:xiaozheliao/screens/search/searcher_screen.dart';
import 'package:xiaozheliao/widgets/contacts/contacts_collections.dart';
import 'package:xiaozheliao/widgets/contacts/contacts_navigation.dart';
import 'package:xiaozheliao/widgets/custom_app_bar.dart';

import '../../widgets/contacts/new_friends_collections.dart';

class ContactsScreen extends StatefulWidget {
  final UserRepository _userRepository;
  final User _user;
  final ContactsRepository _contactsRepository;
  final MessageRepository _messageRepository;

  ContactsScreen({
    Key key,
    @required UserRepository userRepository,
    @required User user,
    @required ContactsRepository contactsRepository,
    @required MessageRepository messageRepository,
  })  : assert(userRepository != null),
        assert(user != null),
        assert(contactsRepository != null),
        assert(messageRepository != null),
        _userRepository = userRepository,
        _user = user,
        _contactsRepository = contactsRepository,
        _messageRepository = messageRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactsScreenState();
  }
}

class ContactsScreenState extends State<ContactsScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      int offset = _controller.position.pixels.toInt();
      print("滑动距离$offset");
      int maxScrollExtent = _controller.position.maxScrollExtent.toInt();
      print("滑动到底部$maxScrollExtent");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = buildCustomAppBar(
      context,
      '联系人',
      'assets/images/common/icons/bar/back.png',
      'assets/images/common/icons/barext/add-friends.png',
      'assets/images/common/icons/bar/search.png',
      () => Navigator.pop(context),
      () => _addFriendsScreen(context),
      () => _routeSearchScreen(context),
      null,
    );

    return Scaffold(
      appBar: appBar,
      body: BlocProvider<ContactsBloc>(
        create: (context) =>
            ContactsBloc(contactsRepository: widget._contactsRepository),
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is InitialContactsState) {
              BlocProvider.of<ContactsBloc>(context).add(ContactsTabsChanged(
                currentIndex: state.currentIndex,
                userUid: widget._user.uid,
              ));
            }
            Widget module = Container();
            if (state is OftenChatTab) {
              module = _mapItemsToGoodsFriendsModule(items: state.items);
            }
            if (state is GoodsFriendsTab) {
              module = _mapItemsToGoodsFriendsModule(items: state.items);
            }
            if (state is NewFriendsTab) {
              module = _mapItemsToNewFriendsModule(items: state.items);
            }
            return Column(
              children: <Widget>[
                ContactsNavigation(
                  elevation: 0.0,
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    BlocProvider.of<ContactsBloc>(context).add(
                      ContactsTabsChanged(
                        currentIndex: index,
                        userUid: widget._user.uid,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: module,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _mapItemsToNewFriendsModule({List<NewFriends> items}) {
    return NewFriendsCollections(
      userRepository: widget._userRepository,
      user: widget._user,
      items: items,
    );
  }

  Widget _mapItemsToGoodsFriendsModule({Map<String, Set<GoodFriends>> items}) {
    return ContactsCollections(
      userRepository: widget._userRepository,
      user: widget._user,
      contactsRepository: widget._contactsRepository,
      controller: _controller,
      items: items,
      messageRepository: widget._messageRepository,
    );
  }

  void _addFriendsScreen(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => AddFriendsScreen(
          userRepository: widget._userRepository,
          user: widget._user,
        ),
      ),
    );
  }

  void _routeSearchScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SearcherScreen(
          userRepository: widget._userRepository,
          user: widget._user,
        ),
      ),
    );
  }
}
