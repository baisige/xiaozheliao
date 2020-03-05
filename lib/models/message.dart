import 'dart:convert';

import 'package:intl/intl.dart';

final String tableMessage = "Message";

final String columnId = "id";
final String columnContent = "content";
final String columnSender = "sender";
final String columnReceiver = "receiver";
final String columnCancel = "cancel";
final String columnHasRead = "hasRead";
final String columnType = "type";
final String columnStatus = "status";
final String columnFilename = "filename";
final String columnLength = "length";
final String columnSendDate = "sendDate";
final String columnLastUpdate = "lastUpdate";

String get createMessageTable => '''
        create table $tableMessage (
        $columnId text primary key, 
        $columnContent text not null,
        $columnSender text not null,
        $columnReceiver text not null,
        $columnCancel integer,
        $columnHasRead integer,
        $columnType integer,
        $columnStatus integer,
        $columnFilename text,
        $columnLength integer,
        $columnSendDate text,
        $columnLastUpdate text)
        ''';

enum Status { SENDING, LOSE, RECEIVED }

enum MessageType { TEXT, EMOJI, FILE, PICTURE, VIDEO, AUDIO, SOURCE }

class Message {
  String id;
  String content;
  String sender;
  String receiver;
  bool cancel;
  bool hasRead;
  MessageType type;
  Status status;
  String filename;
  int length;
  String sendDate;
  String lastUpdate;

  Message.fromMap(Map map) {
    id = map[columnId] as String;
    content = map[columnContent] as String;
    sender = map[columnSender] as String;
    receiver = map[columnReceiver] as String;
    cancel = map[columnCancel] as bool;
    hasRead = map[columnHasRead] as bool;
    type = getMessageType(map[columnType] as String);
    status = getStatus(map[columnStatus] as String);
    filename = map[columnFilename] as String;
    length = map[columnLength] as int;
    DateTime dateTime = DateTime.parse(map[columnSendDate]);
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    sendDate = dateFormat.format(dateTime);
    dateTime = DateTime.parse(map[columnLastUpdate]);
    lastUpdate = dateFormat.format(dateTime);
  }

  MessageType getMessageType(String messageType) {
    int type = 0;
    switch (messageType) {
      case 'TEXT':
        type = 0;
        break;
      case 'EMOJI':
        type = 1;
        break;
      case 'FILE':
        type = 2;
        break;
      case 'PICTURE':
        type = 3;
        break;
      case 'VIDEO':
        type = 4;
        break;
      case 'AUDIO':
        type = 5;
        break;
      case 'SOURCE':
        type = 6;
        break;
    }
    return MessageType.values[type];
  }

  Status getStatus(String status) {
    int state = 0;
    switch (status) {
      case 'SENDING':
        state = 0;
        break;
      case 'LOSE':
        state = 1;
        break;
      case 'RECEIVED':
        state = 2;
        break;
    }
    return Status.values[state];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: id,
      columnContent: content,
      columnSender: sender,
      columnReceiver: receiver,
      columnCancel: cancel,
      columnHasRead: hasRead,
      columnType: type.index,
      columnStatus: status.index,
      columnFilename: filename,
      columnLength: length,
      columnSendDate: sendDate,
      columnLastUpdate: lastUpdate,
    };
  }

  @override
  String toString() => jsonEncode(this.toMap());
}
