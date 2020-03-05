import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class MessageApiClient {
  final Dio dio;

  MessageApiClient({@required this.dio}) : assert(dio != null);
}
