import 'package:dart_amqp/dart_amqp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xiaozheliao/blocs/home/home_bloc.dart';
import 'package:xiaozheliao/models/auth.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/amqp.dart';
import 'package:xiaozheliao/repositories/chat/message_api_client.dart';
import 'package:xiaozheliao/repositories/chat/message_provider.dart';
import 'package:xiaozheliao/repositories/chat/message_repository.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_api_client.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_provider.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_repository.dart';
import 'package:xiaozheliao/repositories/contacts/add_friends_provider.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/home/screen_selector.dart';
import 'package:xiaozheliao/widgets/home/bottom_nav_bar_item.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final Auth _auth;
  final User _user;

  HomeScreen({
    Key key,
    @required UserRepository userRepository,
    @required Auth auth,
    @required User user,
  })  : assert(userRepository != null),
        assert(auth != null),
        assert(user != null),
        _userRepository = userRepository,
        _auth = auth,
        _user = user,
        super(key: key);

  final List<BottomNavBarItem> items = <BottomNavBarItem>[
    BottomNavBarItem(
      icon: 'assets/images/home/notices.png',
      title: '通知',
      activeIcon: 'assets/images/home/notices-active.png',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/home/jobs.png',
      title: '兼职圈',
      activeIcon: 'assets/images/home/jobs-active.png',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/home/my.png',
      title: '我的',
      activeIcon: 'assets/images/home/my-active.png',
      //backgroundColor: Colors.orange
    ),
  ];

  final Client client = new Client(
    settings: ConnectionSettings(
      host: amqpHost,
      authProvider: const PlainAuthenticator(userName, password),
    ),
  );

  Dio get dio => _userRepository.userApiClient.dio;

  Database get db => _userRepository.userProvider.db;

  @override
  Widget build(BuildContext context) {
    final messageProvider = MessageProvider(db: this.db);

    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(userRepository: _userRepository),
      child: ScreenSelector(
        items: items,
        userRepository: _userRepository,
        auth: _auth,
        user: _user,
        contactsRepository: ContactsRepository(
          contactsApiClient: ContactsApiClient(dio: dio),
          contactsProvider: ContactsProvider(db: db),
          addFriendsProvider: AddFriendsProvider(db: db),
          userProvider: _userRepository.userProvider,
          messageProvider: messageProvider,
        ),
        client: client,
        messageRepository: MessageRepository(
          messageApiClient: MessageApiClient(dio: dio),
          messageProvider: messageProvider,
        ),
      ),
    );
  }
}
