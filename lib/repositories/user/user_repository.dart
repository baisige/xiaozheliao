import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaozheliao/models/auth.dart';
import 'package:xiaozheliao/models/response_entity.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_provider.dart';

import 'user_api_client.dart';

class UserRepository {
  final UserApiClient userApiClient;
  final UserProvider userProvider;
  final SharedPreferences prefs;

  UserRepository(
      {@required this.userApiClient,
      @required this.userProvider,
      @required this.prefs})
      : assert(userApiClient != null),
        assert(userProvider != null),
        assert(prefs != null);

  // 检测首次启动
  Future<bool> isFirstStart() async {
    return prefs.getBool('firstStart') ?? true;
  }

  // 设置首次启动
  Future<void> setFirstStart() async {
    prefs.setBool('firstStart', false);
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 2000));
    return;
  }

  Future<void> persistToken(String auth) async {
    prefs.setString('auth', auth);
  }

  Future<Auth> getToken() async {
    String authStr = prefs.getString('auth');
    return Auth.fromMap(jsonDecode(authStr));
  }

  Future<void> signOut() async {
    await prefs.remove('auth');
    await prefs.remove('user');
  }

  Future<User> getUser() async {
    final userStr = prefs.getString('user');
    User user;
    if (userStr != null) {
      user = User.fromMap(jsonDecode(userStr));
    } else {
      user = await userApiClient.getUser();
      if (user != null) {
        prefs.setString('user', jsonEncode(user.toMap()));
      }
    }
    return user;
  }

  Future<User> getUserData(String userUid) async {
    return await userApiClient.getUserData(userUid);
  }

  Future<ResponseEntity> signInWithCredentials(
    String mobile,
    String password,
  ) async {
    return await userApiClient.signInWithCredentials(mobile, password);
  }

  Future<ResponseEntity> signInWithSms(String mobile, String sms) async {
    return await userApiClient.signInWithSms(mobile, sms);
  }

  Future<ResponseEntity> sendSmsCaptcha(String mobile) async {
    return await userApiClient.sendSmsCaptcha(mobile);
  }

  Future<ResponseEntity> signUp({
    String nickname,
    String mobile,
    String sms,
    String password,
  }) async {
    return await userApiClient.signUp(nickname, mobile, sms, password);
  }

  Future<ResponseEntity> searchAddFriendsUserInfo({
    String uid,
    String keyword,
  }) async {
    return await userApiClient.searchAddFriendsUserInfo(uid, keyword);
  }

  Future<bool> addingFriends({String applyUid, String userUid}) async {
    return await userApiClient.addingFriends(applyUid, userUid);
  }
}
