import 'package:equatable/equatable.dart';

abstract class SmsState extends Equatable {
  final int duration;

  const SmsState(this.duration);

  @override
  List<Object> get props => [duration];
}

class Ready extends SmsState {
  const Ready(int duration) : super(duration);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Paused extends SmsState {
  const Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends SmsState {
  const Running(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Finished extends SmsState {
  const Finished() : super(0);
}
