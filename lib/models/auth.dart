class Auth {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  String jti;

  Auth.fromMap(Map map) {
    accessToken = map['access_token'] as String;
    tokenType = map['token_type'] as String;
    refreshToken = map['refresh_token'] as String;
    expiresIn = map['expires_in'] as int;
    scope = map['scope'] as String;
    jti = map['jti'] as String;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'scope': scope,
      'jti': jti,
    };
  }
}
