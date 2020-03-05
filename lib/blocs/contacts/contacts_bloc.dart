import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:xiaozheliao/models/add_friends.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/new_friends.dart';
import 'package:xiaozheliao/repositories/contacts/contacts_repository.dart';
import './bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepository _contactsRepository;
  final int currentIndex = 0;

  ContactsBloc({
    @required ContactsRepository contactsRepository,
  })  : assert(contactsRepository != null),
        _contactsRepository = contactsRepository;

  @override
  ContactsState get initialState => InitialContactsState(this.currentIndex);

  @override
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    if (event is ContactsTabsChanged) {
      yield* _mapContactsTabsChangedToState(event.currentIndex, event.userUid);
    }
    if (event is NewFriendsHandled) {
      yield* _mapNewFriendsHandledToState(event.addFriends);
    }
  }

  Stream<ContactsState> _mapContactsTabsChangedToState(
      int index, String userUid) async* {
    switch (index) {
      case 0:
        final items = await _contactsRepository.getOftenChatContacts(userUid);
        yield OftenChatTab(currentIndex: index, items: items);
        break;
      case 1:
        final items = await _contactsRepository.getMyContacts(userUid);
        yield GoodsFriendsTab(currentIndex: index, items: items);
        break;
      case 2:
        yield GroupChatTab(currentIndex: index);
        break;
      case 3:
        final items = await _contactsRepository.getMyNewFriendsAll(userUid);
        yield NewFriendsTab(currentIndex: index, items: items);
        break;
      default:
        yield OftenChatTab(currentIndex: index);
        break;
    }
  }

  Stream<ContactsState> _mapNewFriendsHandledToState(
      AddFriends addFriends) async* {
    bool result = await _contactsRepository.handleNewFriendsApply(addFriends);

    if (result) {
      List<NewFriends> items =
          await _contactsRepository.getMyNewFriendsAll(addFriends.userUid);
      yield NewFriendsTab(items: items);
    }
  }
}
