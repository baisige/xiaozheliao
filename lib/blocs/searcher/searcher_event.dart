import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearcherEvent extends Equatable {
  const SearcherEvent();
}

class KeywordChanged extends SearcherEvent {
  final String keyword;

  const KeywordChanged({@required this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() => 'KeywordChanged { keyword :$keyword }';
}

class UserFetched extends SearcherEvent {
  final String uid;
  final String keyword;

  const UserFetched({@required this.uid, @required this.keyword})
      : assert(uid != null),
        assert(keyword != null);

  @override
  List<Object> get props => [uid, keyword];

  @override
  String toString() => 'UserFetched { uid :$uid, keyword :$keyword }';
}
