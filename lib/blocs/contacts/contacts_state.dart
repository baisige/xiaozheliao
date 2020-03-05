import 'package:equatable/equatable.dart';
import 'package:xiaozheliao/models/good_friends.dart';
import 'package:xiaozheliao/models/new_friends.dart';

abstract class ContactsState extends Equatable {
  final int currentIndex;

  const ContactsState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class InitialContactsState extends ContactsState {
  InitialContactsState(int currentIndex) : super(currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class OftenChatTab extends ContactsState {
  final Map<String, Set<GoodFriends>> items;

  OftenChatTab({int currentIndex, this.items})
      : assert(items != null),
        super(currentIndex);

  @override
  List<Object> get props => [currentIndex, items];

  @override
  String toString() =>
      'OftenChatTab { currentIndex: $currentIndex, itemsLength: ${items.length} }';
}

class GoodsFriendsTab extends ContactsState {
  final Map<String, Set<GoodFriends>> items;

  GoodsFriendsTab({int currentIndex, this.items})
      : assert(items != null),
        super(currentIndex);

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() =>
      'GoodsFriendsTab { currentIndex: $currentIndex, itemsLength: ${items.length} }';
}

class GroupChatTab extends ContactsState {
  GroupChatTab({int currentIndex}) : super(currentIndex);

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'GroupChatTab { currentIndex: $currentIndex }';
}

class NewFriendsTab extends ContactsState {
  final List<NewFriends> items;

  NewFriendsTab({int currentIndex, this.items})
      : assert(items != null),
        super(currentIndex);

  @override
  List<Object> get props => [currentIndex, items];

  @override
  String toString() =>
      'NewFriendsTab { currentIndex: $currentIndex, itemsLength: ${items.length} }';
}
