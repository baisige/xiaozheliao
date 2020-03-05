import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class ContactsApiClient {
  final Dio dio;

  ContactsApiClient({@required this.dio}) : assert(dio != null);
}
