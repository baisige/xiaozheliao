import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FriendsApplied) {
      yield* _mapFriendsAppliedToState(event.applyUid, event.userUid);
    }
  }

  Stream<UserState> _mapFriendsAppliedToState(
      String applyUid, String userUid) async* {
    yield AddFriendsLoading();
    try {
      bool result = await _userRepository.addingFriends(
          applyUid: applyUid, userUid: userUid);
      yield AddingFriends(result: result);
    } catch (e) {
      yield FriendAddedError();
    }
  }
}
