import 'package:equatable/equatable.dart';
import 'package:xiaozheliao/models/good_friends.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SingleChatted extends ChatEvent {
  final GoodFriends goodFriends;

  SingleChatted(this.goodFriends);

  @override
  List<Object> get props => [goodFriends];

  @override
  String toString() => 'SingleChatted { goodFriends :$goodFriends }';
}

class GroupChatted extends ChatEvent {
  @override
  List<Object> get props => [];
}
