import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FriendsApplied extends UserEvent {
  final String applyUid;
  final String userUid;

  const FriendsApplied({@required this.applyUid, @required this.userUid});

  @override
  List<Object> get props => [applyUid, userUid];

  @override
  String toString() =>
      'FriendsApplied { applyUid :$applyUid, userUid :$userUid }';
}

class UserFetched extends UserEvent {
  final String keyword;

  const UserFetched({@required this.keyword}) : assert(keyword != null);

  @override
  List<Object> get props => [keyword];

  @override
  String toString() => 'UserFetched { keyword :$keyword }';
}
