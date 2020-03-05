import 'package:dart_amqp/dart_amqp.dart';
import 'package:xiaozheliao/models/add_friends.dart';
import 'package:xiaozheliao/models/contacts.dart';
import 'package:xiaozheliao/models/message.dart';
import 'package:xiaozheliao/repositories/user/user_provider.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';

import 'chat/message_provider.dart';
import 'chat/message_repository.dart';
import 'contacts/add_friends_provider.dart';
import 'contacts/contacts_provider.dart';
import 'contacts/contacts_repository.dart';

const amqpHost = '192.168.10.129';
const userName = 'xzl';
const password = 'linyu';

const xzlExchange = 'xzl.topic';

class Amqp {
  final Client client;
  final String queueName;
  final List<String> routeKeys;
  final UserRepository userRepository;
  final ContactsRepository contactsRepository;
  final MessageRepository messageRepository;

  UserProvider get userProvider => userRepository.userProvider;

  AddFriendsProvider get addFriendsProvider =>
      contactsRepository.addFriendsProvider;

  ContactsProvider get contactsProvider => contactsRepository.contactsProvider;

  MessageProvider get messageProvider => messageRepository.messageProvider;

  Amqp({
    this.client,
    this.queueName,
    this.routeKeys,
    this.userRepository,
    this.contactsRepository,
    this.messageRepository,
  })  : assert(client != null),
        assert(queueName != null),
        assert(routeKeys != null && routeKeys.isNotEmpty),
        assert(userRepository != null),
        assert(contactsRepository != null),
        assert(messageRepository != null);

  Future<void> amqpListening() async {
    Channel channel = await this.client.channel();
    Exchange exchange =
        await channel.exchange(xzlExchange, ExchangeType.TOPIC, passive: true);
    Queue queue = await channel.queue(this.queueName, durable: true);

    this.routeKeys.forEach((key) async => {await queue.bind(exchange, key)});
    Consumer consumer = await queue.consume();
    print("${this.queueName} Receiving message");
    consumer.listen(
      (message) async {
        print("Received ${message.payloadAsString}");
        if (message.routingKey == this.routeKeys[0]) {
          final addFriends = AddFriends.fromMap(message.payloadAsJson);
          await saveUser(addFriends.applyUid);
          await saveAddFriends(addFriends);
        }
        if (message.routingKey == this.routeKeys[1]) {
          final contacts = Contacts.fromMap(message.payloadAsJson);
          await saveUser(contacts.userUid);
          await saveContacts(contacts);
        }
        if (message.routingKey == this.routeKeys[2]) {
          final msg = Message.fromMap(message.payloadAsJson);
          await saveMessage(msg);
        }
      },
    );
  }

  Future<void> saveAddFriends(AddFriends addFriends) async {
    final count = await addFriendsProvider.count(addFriends.id);
    if (count == 0) {
      await addFriendsProvider.insert(addFriends);
    } else {
      await addFriendsProvider.update(addFriends);
    }
  }

  Future<void> saveUser(String userUid) async {
    final user = await userRepository.getUserData(userUid);
    if (user != null) {
      final count = await userProvider.count(user.id);
      if (count == 0) {
        await userProvider.insert(user);
      } else {
        await userProvider.update(user);
      }
    }
  }

  Future<void> saveContacts(Contacts contacts) async {
    final count = await contactsProvider.count(contacts.id);
    if (count == 0) {
      await contactsProvider.insert(contacts);
    } else {
      await contactsProvider.update(contacts);
    }
  }

  Future<void> saveMessage(Message message) async {
    final count = await messageProvider.count(message.id);
    if (count == 0) {
      await messageProvider.insert(message);
    } else {
      await messageProvider.update(message);
    }
  }
}
