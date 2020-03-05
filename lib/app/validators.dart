class Validators {
  static final RegExp _mobileRegExp = RegExp(
    r'^1[3456789]\d{9}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );

  static final RegExp _smsRegExp = RegExp(
    r'^\d{6}$',
  );

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static isValidMobile(String mobile) {
    return _mobileRegExp.hasMatch(mobile);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidSms(String sms) {
    return _smsRegExp.hasMatch(sms);
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidNickname(String nickname) {
    int length = nickname.trim().length;
    return length >= 2 && length <= 30;
  }
}
