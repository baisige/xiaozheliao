import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/widgets/account/login_form.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginModeChanged extends LoginEvent {
  final LoginMode loginMode;

  const LoginModeChanged({@required this.loginMode});

  @override
  List<Object> get props => [loginMode];

  @override
  String toString() => 'LoginModeChanged { mode :$loginMode }';
}

class MobileChanged extends LoginEvent {
  final String mobile;
  final LoginMode loginMode;

  const MobileChanged({@required this.mobile, @required this.loginMode});

  @override
  List<Object> get props => [mobile, loginMode];

  @override
  String toString() => 'MobileChanged { mobile :$mobile }';
}

class PasswordChanged extends LoginEvent {
  final String password;
  final LoginMode loginMode;

  const PasswordChanged({@required this.password, @required this.loginMode});

  @override
  List<Object> get props => [password, loginMode];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class SmsChanged extends LoginEvent {
  final String sms;
  final LoginMode loginMode;

  const SmsChanged({@required this.sms, @required this.loginMode});

  @override
  List<Object> get props => [sms, loginMode];

  @override
  String toString() => 'SmsChanged { sms: $sms }';
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String mobile;
  final String password;

  const LoginWithCredentialsPressed({
    @required this.mobile,
    @required this.password,
  });

  @override
  List<Object> get props => [mobile, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { mobile: $mobile, password: $password }';
  }
}

class LoginWithSmsPressed extends LoginEvent {
  final String mobile;
  final String sms;

  const LoginWithSmsPressed({
    @required this.mobile,
    @required this.sms,
  });

  @override
  List<Object> get props => [mobile, sms];

  @override
  String toString() {
    return 'LoginWithSmsPressed { mobile: $mobile, sms: $sms }';
  }
}
