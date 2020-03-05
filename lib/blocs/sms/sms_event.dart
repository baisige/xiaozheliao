import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SmsEvent extends Equatable {
  const SmsEvent();

  @override
  List<Object> get props => [];
}

class Start extends SmsEvent {
  final int duration;
  final String mobile;

  const Start({@required this.duration, @required this.mobile});

  @override
  String toString() => "Start { duration: $duration,  mobile: $mobile}";
}

class Pause extends SmsEvent {}

class Resume extends SmsEvent {}

class Reset extends SmsEvent {}

class Tick extends SmsEvent {
  final int duration;

  const Tick({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}
