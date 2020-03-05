import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/app/ticker.dart';
import 'package:xiaozheliao/models/response_entity.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import './bloc.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final Ticker _ticker;
  final int _duration = 60;
  final UserRepository _userRepository;

  StreamSubscription<int> _tickerSubscription;

  SmsBloc({@required Ticker ticker, @required UserRepository userRepository})
      : assert(ticker != null),
        assert(userRepository != null),
        _ticker = ticker,
        _userRepository = userRepository;

  @override
  SmsState get initialState => Ready(_duration);

  @override
  Stream<SmsState> mapEventToState(
    SmsEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<SmsState> _mapStartToState(Start start) async* {
    ResponseEntity responseEntity =
        await _userRepository.sendSmsCaptcha(start.mobile);
    _tickerSubscription?.cancel();
    if (responseEntity?.code == Codes.SUCCESS) {
      yield Running(start.duration);
      _tickerSubscription = _ticker
          .tick(ticks: start.duration)
          .listen((duration) => add(Tick(duration: duration)));
    } else {
      yield Ready(_duration);
    }
  }

  Stream<SmsState> _mapPauseToState(Pause pause) async* {
    if (state is Running) {
      _tickerSubscription?.pause();
      yield Paused(state.duration);
    }
  }

  Stream<SmsState> _mapResumeToState(Resume pause) async* {
    if (state is Paused) {
      _tickerSubscription?.resume();
      yield Running(state.duration);
    }
  }

  Stream<SmsState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    yield Ready(_duration);
  }

  Stream<SmsState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished();
  }
}
