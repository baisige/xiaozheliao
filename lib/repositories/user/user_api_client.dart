import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/app/env.dart';
import 'package:xiaozheliao/models/response_entity.dart';
import 'package:xiaozheliao/models/user.dart';

import '../dio_helper.dart';

class UserApiClient {
  final Dio dio;
  String signInUrl = '$baseUrl/user-service/sign-in';

  UserApiClient({@required this.dio}) : assert(dio != null);

  Future<ResponseEntity> signInWithCredentials(
    String mobile,
    String password,
  ) async {
    Map<String, dynamic> data = {'mobile': mobile, 'password': password};
    return await signIn(data);
  }

  Future<ResponseEntity> signIn(Map<String, dynamic> data) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String model = '';
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
    }
    String platform = Platform.operatingSystem;
    data.addAll({'platform': platform, 'model': model});
    try {
      Response response =
          await dio.post(signInUrl, data: FormData.fromMap(data));
      return ResponseEntity.fromMap(response.data);
    } catch (e) {
      print(e);
    }
    return ResponseEntity.netError();
  }

  Future<ResponseEntity> signInWithSms(String mobile, String sms) async {
    return await signIn({'mobile': mobile, 'sms': sms});
  }

  Future<ResponseEntity> sendSmsCaptcha(String mobile) async {
    Response response = await dio.get('$baseUrl/user-service/send-sms/$mobile');
    return ResponseEntity.fromMap(response.data);
  }

  Future<ResponseEntity> signUp(
    String nickname,
    String mobile,
    String sms,
    String password,
  ) async {
    FormData formData = new FormData.fromMap({
      'nickname': nickname,
      'mobile': mobile,
      'password': password,
      'sms': sms,
    });
    String regUrl = '$baseUrl/user-service/reg';
    Response response = await dio.post(regUrl, data: formData);
    return ResponseEntity.fromMap(response.data);
  }

  Future<User> getUser() async {
    String userUrl = '$baseUrl/user-service/user';
    Options options = await getHeadersOptions();
    try {
      Response response = await dio.get(userUrl, options: options);
      if (response.data is Map) {
        return User.fromMap(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User> getUserData(String userUid) async {
    String userUrl = '$baseUrl/user-service/user/data/$userUid';
    Options options = await getHeadersOptions();
    try {
      Response response = await dio.get(userUrl, options: options);
      if (response.data is Map) {
        return User.fromMap(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ResponseEntity> searchAddFriendsUserInfo(
      String uid, String keyword) async {
    Options options = await getHeadersOptions();
    String userUrl = '$baseUrl/user-service/friends/search';
    try {
      Response response = await dio.get(userUrl,
          options: options, queryParameters: {'uid': uid, 'keyword': keyword});
      return ResponseEntity.fromMap(response.data);
    } catch (e) {
      print(e);
    }
    return ResponseEntity.netError();
  }

  Future<bool> addingFriends(String applyUid, String userUid) async {
    Options options = await getHeadersOptions();
    String userUrl = '$baseUrl/user-service/friends/apply';
    FormData formData =
        new FormData.fromMap({'applyUid': applyUid, 'userUid': userUid});
    try {
      Response response =
          await dio.post(userUrl, data: formData, options: options);
      return response.data;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
