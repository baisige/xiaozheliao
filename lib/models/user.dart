import 'dart:convert';

final String tableUser = "User";

final String columnId = "id";
final String columnUid = "uid";
final String columnUsername = "username";
final String columnNickname = "nickname";
final String columnMobile = "mobile";
final String columnPhoto = "photo";
final String columnPosition = "position";
final String columnJobSeekState = "jobSeekState";
final String columnSignature = "signature";
final String columnSchool = "school";
final String columnGender = "gender";
final String columnSkills = "skills";
final String columnEnable = "enable";
final String columnCreateDate = "createDate";

String get createUserTable => '''
        create table $tableUser (
        $columnId integer primary key,
        $columnUid text not null,
        $columnUsername text not null,
        $columnNickname text not null,
        $columnMobile text not null,
        $columnPhoto text,
        $columnPosition text,
        $columnJobSeekState text,
        $columnSignature text,
        $columnSchool text,
        $columnGender text,
        $columnSkills text,
        $columnEnable integer,
        $columnCreateDate text)
        ''';

class User {
  int id;
  String uid;
  String username;
  String nickname;
  String mobile;
  String photo;
  String position;
  String jobSeekState;
  String signature;
  String school;
  String gender;
  String skills;
  bool enable;
  String createDate;

  User.fromMap(Map map) {
    id = map[columnId] as int;
    uid = map[columnUid] as String;
    username = map[columnUsername] as String;
    nickname = map[columnNickname] as String;
    mobile = map[columnMobile] as String;
    photo = map[columnPhoto] as String;
    position = map[columnPosition] as String;
    jobSeekState = map[columnJobSeekState] as String;
    signature = map[columnSignature] as String;
    school = map[columnSchool] as String;
    gender = map[columnGender] as String;
    skills = map[columnSkills] as String;
    if (map[columnEnable] is int) {
      enable = map[columnEnable] == 0 ? false : true;
    } else {
      enable = map[columnEnable] as bool;
    }
    createDate = map[columnCreateDate] as String;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: id,
      columnUid: uid,
      columnUsername: username,
      columnNickname: nickname,
      columnMobile: mobile,
      columnPhoto: photo,
      columnPosition: position,
      columnJobSeekState: jobSeekState,
      columnSignature: signature,
      columnSchool: school,
      columnGender: gender,
      columnSkills: skills,
      columnEnable: enable,
      columnCreateDate: createDate,
    };
  }

  @override
  String toString() => jsonEncode(this.toMap());
}
