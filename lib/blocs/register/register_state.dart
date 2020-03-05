import 'package:meta/meta.dart';

class RegisterState {
  final bool isNicknameValid;
  final bool isMobileValid;
  final bool isSmsValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isAgree;
  String message;

  bool get isFormValid =>
      isNicknameValid &&
      isMobileValid &&
      isSmsValid &&
      isPasswordValid &&
      isAgree;

  RegisterState({
    @required this.isNicknameValid,
    @required this.isMobileValid,
    @required this.isSmsValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isAgree,
    this.message,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isNicknameValid: true,
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isAgree: true,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isNicknameValid: true,
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isAgree: true,
    );
  }

  factory RegisterState.failure(String message) {
    return RegisterState(
      isNicknameValid: true,
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isAgree: true,
      message: message,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isNicknameValid: true,
      isMobileValid: true,
      isPasswordValid: true,
      isSmsValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isAgree: true,
    );
  }

  RegisterState update({
    bool isNicknameValid,
    bool isMobileValid,
    bool isPasswordValid,
    bool isSmsValid,
    bool isAgree,
  }) {
    return copyWith(
      isNicknameValid: isNicknameValid,
      isMobileValid: isMobileValid,
      isPasswordValid: isPasswordValid,
      isSmsValid: isSmsValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isAgree: isAgree,
    );
  }

  RegisterState copyWith({
    bool isNicknameValid,
    bool isMobileValid,
    bool isPasswordValid,
    bool isSmsValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isAgree,
  }) {
    return RegisterState(
      isNicknameValid: isNicknameValid ?? this.isNicknameValid,
      isMobileValid: isMobileValid ?? this.isMobileValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSmsValid: isSmsValid ?? this.isSmsValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isAgree: isAgree ?? this.isAgree,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isNicknameValid: $isNicknameValid,
      isMobileValid: $isMobileValid,
      isPasswordValid: $isPasswordValid,      
      isSmsValid: $isSmsValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isAgree: $isAgree,
      message: $message,
    }''';
  }
}
