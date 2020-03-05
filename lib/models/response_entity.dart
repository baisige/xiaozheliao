enum Codes { SUCCESS, ERROR }

class ResponseEntity {
  Codes code;
  String message;
  Object data;

  ResponseEntity.fromMap(Map map) {
    if (map['code'] == 'SUCCESS') {
      code = Codes.SUCCESS;
    } else {
      code = Codes.ERROR;
    }
    message = map['message'] as String;
    data = map['data'] as Object;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'data': data,
    };
  }

  ResponseEntity.netError() {
    code = Codes.ERROR;
    message = '网络连接异常，请检查';
  }
}
