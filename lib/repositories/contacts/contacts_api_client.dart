import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/app/env.dart';
import 'package:xiaozheliao/models/add_friends.dart';
import 'package:xiaozheliao/models/response_entity.dart';

import '../dio_helper.dart';

class ContactsApiClient {
  final Dio dio;

  ContactsApiClient({@required this.dio}) : assert(dio != null);

  Future<ResponseEntity> handleNewFriendsApply(AddFriends addFriends) async {
    Options options = await getHeadersOptions();
    String userUrl = '$baseUrl/user-service/friends/new/handle';
    print(jsonEncode(addFriends.toMap()));
    FormData formData = new FormData.fromMap(addFriends.toMap());
    try {
      Response response =
          await dio.post(userUrl, data: formData, options: options);
      return ResponseEntity.fromMap(response.data);
    } catch (e) {
      print(e);
    }
    return ResponseEntity.netError();
  }
}
