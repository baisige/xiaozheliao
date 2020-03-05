import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/friend.dart';
import 'package:xiaozheliao/models/response_entity.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import './bloc.dart';

class SearcherBloc extends Bloc<SearcherEvent, SearcherState> {
  final UserRepository _userRepository;

  SearcherBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SearcherState get initialState => SearcherEmpty();

  @override
  Stream<SearcherState> mapEventToState(
    SearcherEvent event,
  ) async* {
    if (event is KeywordChanged) {
      yield* _mapKeywordChangedToState(event.keyword);
    } else if (event is UserFetched) {
      yield* _mapUserFetchedToState(event.uid, event.keyword);
    }
  }

  Stream<SearcherState> _mapKeywordChangedToState(String keyword) async* {
    yield KeywordChanging(keyword.isNotEmpty);
  }

  Stream<SearcherState> _mapUserFetchedToState(
      String uid, String keyword) async* {
    yield SearcherLoading();
    try {
      ResponseEntity responseEntity = await _userRepository
          .searchAddFriendsUserInfo(uid: uid, keyword: keyword);
      if (responseEntity.code == Codes.SUCCESS) {
        yield SearcherFriendLoaded(friend: Friend.fromMap(responseEntity.data));
      } else {
        yield SearcherError(message: responseEntity.message);
      }
    } catch (e) {
      yield SearcherError(message: e.toString());
    }
  }
}
