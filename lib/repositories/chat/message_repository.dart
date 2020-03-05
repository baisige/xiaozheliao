import 'package:meta/meta.dart';
import 'package:xiaozheliao/models/message.dart';

import 'message_api_client.dart';
import 'message_provider.dart';

class MessageRepository {
  final MessageApiClient messageApiClient;
  final MessageProvider messageProvider;

  MessageRepository({
    @required this.messageApiClient,
    @required this.messageProvider,
  })  : assert(messageApiClient != null),
        assert(messageProvider != null);

  Future<List<Message>> fetchMessages(
      int start, int limit, String sender, String receiver) async {
    List<Message> messages =
        await messageProvider.getMessagePage(limit, start, sender, receiver);
    return messages;
  }
}
