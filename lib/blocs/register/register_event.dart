import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class NicknameChanged extends RegisterEvent {
  final String nickname;

  const NicknameChanged({@required this.nickname});

  @override
  List<Object> get props => [nickname];

  @override
  String toString() => 'NicknameChanged { nickname :$nickname }';
}

class MobileChanged extends RegisterEvent {
  final String mobile;

  const MobileChanged({@required this.mobile});

  @override
  List<Object> get props => [mobile];

  @override
  String toString() => 'MobileChanged { mobile :$mobile }';
}

class SmsChanged extends RegisterEvent {
  final String sms;

  const SmsChanged({@required this.sms});

  @override
  List<Object> get props => [sms];

  @override
  String toString() => 'SmsChanged { sms :$sms }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class TermsAgreed extends RegisterEvent {
  final bool isAgree;

  const TermsAgreed({@required this.isAgree});

  @override
  List<Object> get props => [isAgree];

  @override
  String toString() => 'TermsAgreed { isAgree: $isAgree }';
}

class Submitted extends RegisterEvent {
  final String nickname;
  final String mobile;
  final String sms;
  final String password;

  const Submitted({
    @required this.nickname,
    @required this.mobile,
    @required this.sms,
    @required this.password,
  });

  @override
  List<Object> get props => [
        nickname,
        mobile,
        sms,
        password,
      ];

  @override
  String toString() {
    return '''Submitted { 
      nickname: $nickname, 
      mobile: $mobile, 
      sms: $sms, 
      password: $password 
    }''';
  }
}
