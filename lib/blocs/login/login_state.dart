import 'package:meta/meta.dart';
import 'package:xiaozheliao/widgets/account/login_form.dart';

class LoginState {
  final bool isMobileValid;
  final bool isPasswordValid;
  final bool isSmsValid;
  final LoginMode loginMode;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  String message;

  bool get isPasswordFormValid => isMobileValid && isPasswordValid;

  bool get isSmsFormValid => isMobileValid && isSmsValid;

  LoginState({
    @required this.isMobileValid,
    @required this.isPasswordValid,
    @required this.isSmsValid,
    @required this.loginMode,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    this.message,
  });

  factory LoginState.empty() {
    return LoginState(
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: false,
      loginMode: LoginMode.PASSWORD,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      loginMode: LoginMode.PASSWORD,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure(LoginMode loginMode, String message) {
    return LoginState(
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      loginMode: loginMode,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message: message,
    );
  }

  factory LoginState.success(
    LoginMode loginMode,
  ) {
    return LoginState(
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      loginMode: loginMode,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update({
    bool isMobileValid,
    bool isPasswordValid,
    bool isSmsValid,
    LoginMode loginMode,
  }) {
    return copyWith(
      isMobileValid: isMobileValid,
      isPasswordValid: isPasswordValid,
      isSmsValid: isSmsValid,
      loginMode: loginMode,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool isMobileValid,
    bool isPasswordValid,
    bool isSmsValid,
    LoginMode loginMode,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return LoginState(
      isMobileValid: isMobileValid ?? this.isMobileValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSmsValid: isSmsValid ?? this.isSmsValid,
      loginMode: loginMode ?? this.loginMode,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isMobileValid: $isMobileValid,
      isPasswordValid: $isPasswordValid,      
      isSmsValid: $isSmsValid,      
      loginMode: $loginMode,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      message: $message,
    }''';
  }
}
