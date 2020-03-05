import 'package:equatable/equatable.dart';
import 'package:xiaozheliao/models/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatUninitialized extends ChatState {}

class ChatError extends ChatState {}

class SingleChatLoaded extends ChatState {
  final List<Message> messages;
  final bool hasReachedMax;

  const SingleChatLoaded({
    this.messages,
    this.hasReachedMax,
  });

  SingleChatLoaded copyWith({
    List<Message> messages,
    bool hasReachedMax,
  }) {
    return SingleChatLoaded(
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [messages, hasReachedMax];

  @override
  String toString() =>
      'SingleChatLoaded { messages: ${messages.length}, hasReachedMax: $hasReachedMax }';
}
