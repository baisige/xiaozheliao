import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'contacts.dart';

// ignore: must_be_immutable
class GoodFriends extends Equatable {
  String name;
  String photo;
  Contacts contacts;

  GoodFriends.fromMap(Map map) {
    name = map['name'] as String;
    photo = map['photo'] as String;
    contacts = map['contacts'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photo': photo,
      'contacts': contacts,
    };
  }

  @override
  List<Object> get props => [];

  @override
  String toString() => jsonEncode(this.toMap());
}
