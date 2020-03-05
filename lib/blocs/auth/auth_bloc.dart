import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/auth.dart';
import 'package:xiaozheliao/repositories/repositories.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is Experienced) {
      yield* _mapExperiencedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    final isFirstAuth = await _userRepository.isFirstStart();
    if (isFirstAuth) {
      yield FirstStarted();
    } else {
      try {
        yield AuthLoading();
        Auth auth = await _userRepository.getToken();
        if (auth != null && auth.accessToken.isNotEmpty) {
          final user = await _userRepository.getUser();
          yield Authenticated(auth, user);
        } else {
          yield Unauthenticated();
        }
      } catch (_) {
        yield Unauthenticated();
      }
    }
  }

  Stream<AuthState> _mapExperiencedToState() async* {
    await _userRepository.setFirstStart();
    yield Unauthenticated();
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final Auth auth = await _userRepository.getToken();
    final user = await _userRepository.getUser();
    yield Authenticated(auth, user);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    await _userRepository.signOut();
    yield Unauthenticated();
  }
}
