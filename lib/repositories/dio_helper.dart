import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Options> getHeadersOptions() async {
  final prefs = await SharedPreferences.getInstance();
  String authStr = prefs.getString('auth');
  Map auth = jsonDecode(authStr);
  Options options = Options(
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'bearer ${auth['access_token']}',
    },
  );
  return options;
}
