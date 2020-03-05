import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class InitialUserState extends UserState {
  @override
  List<Object> get props => [];
}

class AddFriendsLoading extends InitialUserState {}

class AddingFriends extends InitialUserState {
  final bool result;

  AddingFriends({this.result});
}

class FriendAddedError extends InitialUserState {}
