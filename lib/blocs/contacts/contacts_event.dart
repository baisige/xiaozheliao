import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/add_friends.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class ContactsTabsChanged extends ContactsEvent {
  final int currentIndex;
  final String userUid;

  ContactsTabsChanged({@required this.currentIndex, @required this.userUid});

  @override
  List<Object> get props => [currentIndex, userUid];
}

class NewFriendsFetched extends ContactsEvent {}

class NewFriendsHandled extends ContactsEvent {
  final AddFriends addFriends;

  NewFriendsHandled({@required this.addFriends});

  @override
  List<Object> get props => [addFriends];
}
