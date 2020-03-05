import 'package:equatable/equatable.dart';
import 'package:xiaozheliao/models/auth.dart';
import 'package:xiaozheliao/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class InitialAuthState extends AuthState {
  const InitialAuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends InitialAuthState {}

class FirstStarted extends InitialAuthState {}

class Authenticated extends InitialAuthState {
  final Auth auth;
  final User user;

  const Authenticated(this.auth, this.user)
      : assert(auth != null),
        assert(user != null);

  @override
  List<Object> get props => [auth, user];

  @override
  String toString() => 'Authenticated { auth: $auth, user: $user }';
}

class Unauthenticated extends InitialAuthState {}

class AuthLoading extends InitialAuthState {}
