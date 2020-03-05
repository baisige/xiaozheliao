import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xiaozheliao/repositories/chat/message_repository.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final MessageRepository _messageRepository;

  ChatBloc({
    @required MessageRepository messageRepository,
  })  : assert(messageRepository != null),
        _messageRepository = messageRepository;

  @override
  ChatState get initialState => ChatUninitialized();

  @override
  Stream<ChatState> transformEvents(
    Stream<ChatEvent> events,
    Stream<ChatState> Function(ChatEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    final currentState = state;
    if (event is SingleChatted && !_hasReachedMax(currentState)) {
      String sender = event.goodFriends.contacts.userUid;
      String receiver = event.goodFriends.contacts.myUid;
      try {
        if (currentState is ChatUninitialized) {
          final messages =
              await _messageRepository.fetchMessages(0, 10, sender, receiver);
          yield SingleChatLoaded(messages: messages, hasReachedMax: false);
          return;
        }
        if (currentState is SingleChatLoaded) {
//          final posts = await _fetchPosts(currentState.posts.length, 20);
//          yield posts.isEmpty
//              ? currentState.copyWith(hasReachedMax: true)
//              : SingleChatLoaded(
//                  posts: currentState.posts + posts,
//                  hasReachedMax: false,
//                );
        }
      } catch (_) {
        yield ChatError();
      }
    }
  }

  bool _hasReachedMax(ChatState state) =>
      state is SingleChatLoaded && state.hasReachedMax;
}
