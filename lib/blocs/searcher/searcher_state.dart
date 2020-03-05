import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/friend.dart';

abstract class SearcherState extends Equatable {
  const SearcherState();

  @override
  List<Object> get props => [];
}

class SearcherEmpty extends SearcherState {}

class KeywordChanging extends SearcherState {
  final bool isClean;

  const KeywordChanging(this.isClean);

  @override
  List<Object> get props => [isClean];
}

class SearcherLoading extends SearcherState {}

class SearcherFriendLoaded extends SearcherState {
  final Friend friend;

  const SearcherFriendLoaded({@required this.friend}) : assert(friend != null);

  @override
  List<Object> get props => [friend];
}

class SearcherError extends SearcherState {
  final String message;

  const SearcherError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}
