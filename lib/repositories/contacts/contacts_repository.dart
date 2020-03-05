import 'package:lpinyin/lpinyin.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/add_friends.dart';
import 'package:xiaozheliao/models/contacts.dart';
import 'package:xiaozheliao/models/good_friends.dart';
import 'package:xiaozheliao/models/new_friends.dart';
import 'package:xiaozheliao/models/response_entity.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/chat/message_provider.dart';
import 'package:xiaozheliao/repositories/user/user_provider.dart';
import 'package:xiaozheliao/screens/contacts/letter_searcher.dart';

import 'contacts_api_client.dart';
import 'contacts_provider.dart';
import 'add_friends_provider.dart';

class ContactsRepository {
  final ContactsApiClient contactsApiClient;
  final ContactsProvider contactsProvider;
  final AddFriendsProvider addFriendsProvider;
  final UserProvider userProvider;
  final MessageProvider messageProvider;

  ContactsRepository(
      {@required this.contactsApiClient,
      @required this.contactsProvider,
      @required this.addFriendsProvider,
      @required this.userProvider,
      @required this.messageProvider})
      : assert(contactsApiClient != null),
        assert(contactsProvider != null),
        assert(addFriendsProvider != null),
        assert(userProvider != null),
        assert(messageProvider != null);

  Future<List<NewFriends>> getMyNewFriendsAll(String userUid) async {
    List<AddFriends> addFriendsList =
        await addFriendsProvider.getAddFriends(userUid);
    List<NewFriends> newFriendsList = [];
    for (AddFriends addFriends in addFriendsList) {
      User user = await userProvider.getUser(addFriends.applyUid);
      if (user != null) {
        newFriendsList.add(NewFriends.fromMap({
          'name': user.nickname,
          'photo': user.photo,
          'addFriends': addFriends
        }));
      }
    }
    return newFriendsList;
  }

  Future<bool> handleNewFriendsApply(AddFriends addFriends) async {
    ResponseEntity responseEntity =
        await contactsApiClient.handleNewFriendsApply(addFriends);
    if (responseEntity.code == Codes.SUCCESS) {
      int row = await addFriendsProvider.update(addFriends);
      return row > 0;
    }
    return false;
  }

  Future<Map<String, Set<GoodFriends>>> getMyContacts(String myUid) async {
    final items = await contactsProvider.getMyContacts(myUid);
    Map<String, Set<GoodFriends>> myGoodFriends = Map();
    for (Contacts contacts in items) {
      final user = await userProvider.getUser(contacts.userUid);
      if (user != null) {
        String name = contacts.noteName ?? user.nickname;
        final pinyin = PinyinHelper.getFirstWordPinyin(name);
        String letter = pinyin.substring(0, 1).toUpperCase();
        if (!letterTitle.contains(letter)) {
          letter = '#';
        }
        Set<GoodFriends> friends = myGoodFriends[letter] ?? {};
        friends.add(GoodFriends.fromMap({
          'name': name,
          'photo': user.photo,
          'contacts': contacts,
        }));
        myGoodFriends[letter] = friends;
      }
    }
    return myGoodFriends;
  }

  Future<Map<String, Set<GoodFriends>>> getOftenChatContacts(
      String myUid) async {
    final items = await contactsProvider.getMyContacts(myUid);
    Map<String, Set<GoodFriends>> myGoodFriends = Map();
    for (Contacts contacts in items) {
      final count = await messageProvider.getGoodFriendsMessageCount(
          contacts.myUid, contacts.userUid);
      if (count == 0) continue;
      final user = await userProvider.getUser(contacts.userUid);
      if (user != null) {
        String name = contacts.noteName ?? user.nickname;
        final pinyin = PinyinHelper.getFirstWordPinyin(name);
        String letter = pinyin.substring(0, 1).toUpperCase();
        if (!letterTitle.contains(letter)) {
          letter = '#';
        }
        Set<GoodFriends> friends = myGoodFriends[letter] ?? {};
        friends.add(GoodFriends.fromMap({
          'name': name,
          'photo': user.photo,
          'contacts': contacts,
        }));
        myGoodFriends[letter] = friends;
      }
    }
    return myGoodFriends;
  }
}
