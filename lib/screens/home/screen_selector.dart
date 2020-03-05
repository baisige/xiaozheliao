import 'package:dart_amqp/dart_amqp.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/auth.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/amqp.dart';
import 'package:xiaozheliao/repositories/chat/message_repository.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_repository.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/contacts/contacts_screen.dart';
import 'package:xiaozheliao/screens/my/my_screen.dart';
import 'package:xiaozheliao/screens/notices/notices_screen.dart';
import 'package:xiaozheliao/screens/search/searcher_screen.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/custom_app_bar.dart';
import 'package:xiaozheliao/widgets/home/bottom_nav_bar.dart';
import 'package:xiaozheliao/widgets/home/bottom_nav_bar_item.dart';

class ScreenSelector extends StatefulWidget {
  final List<BottomNavBarItem> items;
  final UserRepository _userRepository;
  final Auth _auth;
  final User _user;
  final ContactsRepository _contactsRepository;
  final Client _client;
  final MessageRepository _messageRepository;

  ScreenSelector({
    Key key,
    this.items,
    @required UserRepository userRepository,
    @required Auth auth,
    @required User user,
    @required ContactsRepository contactsRepository,
    @required Client client,
    @required MessageRepository messageRepository,
  })  : assert(userRepository != null),
        assert(user != null),
        assert(contactsRepository != null),
        assert(client != null),
        assert(messageRepository != null),
        _userRepository = userRepository,
        _auth = auth,
        _user = user,
        _contactsRepository = contactsRepository,
        _client = client,
        _messageRepository = messageRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenSelectorState();
  }
}

class _ScreenSelectorState extends State<ScreenSelector> {
  int _currentIndex = 0;
  bool _isMore = false;
  Timer _timer;
  Amqp amqp;

  String get queueName => 'app.xzl.${widget._auth.jti}';

  String get uid => widget._user.uid;

  List<String> get routeKeys => [
        'add.friends.$uid',
        'contacts.$uid',
        'chat.message.$uid',
      ];

  @override
  void initState() {
    super.initState();
    amqp = Amqp(
      client: widget._client,
      queueName: queueName,
      routeKeys: routeKeys,
      userRepository: widget._userRepository,
      contactsRepository: widget._contactsRepository,
      messageRepository: widget._messageRepository,
    )..amqpListening();

//    _timer = new Timer.periodic(new Duration(seconds: 30), (timer) {
//      print(widget._user);
//    });
  }

  @override
  void dispose() {
    widget._client?.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isMore && _currentIndex != 0) _isMore = false;

    Widget appBar;
    Widget body;
    switch (_currentIndex) {
      case 0:
        appBar = buildCustomAppBar(
          context,
          '通知',
          'assets/images/common/icons/bar/more.png',
          'assets/images/common/icons/bar/contacts.png',
          'assets/images/common/icons/bar/search.png',
          _toggleMoreAppBar,
          _routeContactsScreen,
          _routeSearchScreen,
          _closeMoreAppBar,
        );
        body = NoticesScreen(
          isMore: _isMore,
          closeMoreBar: _closeMoreAppBar,
          userRepository: widget._userRepository,
          user: widget._user,
        );
        break;
      case 1:
        body = Container();
        break;
      case 2:
        body = MyScreen(
          userRepository: widget._userRepository,
          user: widget._user,
          client: widget._client,
        );
        break;
    }

    BottomNavBar bottomNavBar = BottomNavBar(
      items: widget.items,
      currentIndex: _currentIndex,
      selectedColor: XzlColors.ff53cac3,
      unselectedColor: XzlColors.ff666666,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        top: false,
        child: body,
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }

  void _toggleMoreAppBar() {
    setState(() {
      _isMore = !_isMore;
    });
  }

  void _closeMoreAppBar() {
    setState(() {
      _isMore = false;
    });
  }

  void _routeContactsScreen() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => ContactsScreen(
          userRepository: widget._userRepository,
          user: widget._user,
          contactsRepository: widget._contactsRepository,
          messageRepository: widget._messageRepository,
        ),
      ),
    );
  }

  void _routeSearchScreen() {
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
