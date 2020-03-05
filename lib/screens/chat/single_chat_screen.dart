import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/chat/chat_bloc.dart';
import 'package:xiaozheliao/blocs/chat/chat_event.dart';
import 'package:xiaozheliao/models/good_friends.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/chat/message_repository.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_repository.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/chat/single_chatter.dart';
import 'package:xiaozheliao/widgets/custom_app_bar.dart';

class SingleChatScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;
  final ContactsRepository _contactsRepository;
  final GoodFriends _goodFriends;
  final MessageRepository _messageRepository;

  SingleChatScreen({
    Key key,
    @required UserRepository userRepository,
    @required User user,
    @required ContactsRepository contactsRepository,
    @required GoodFriends goodFriends,
    @required MessageRepository messageRepository,
  })  : assert(userRepository != null),
        assert(user != null),
        assert(contactsRepository != null),
        assert(goodFriends != null),
        assert(messageRepository != null),
        _userRepository = userRepository,
        _user = user,
        _contactsRepository = contactsRepository,
        _goodFriends = goodFriends,
        _messageRepository = messageRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChildCustomAppBar(context, _goodFriends.name, null, null),
      body: BlocProvider(
        create: (context) => ChatBloc(messageRepository: _messageRepository)
          ..add(SingleChatted(_goodFriends)),
        child: SingleChatter(),
      ),
    );
  }
}
