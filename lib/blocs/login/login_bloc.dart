import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/app/validators.dart';
import 'package:xiaozheliao/models/response_entity.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/widgets/account/login_form.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! MobileChanged &&
          event is! PasswordChanged &&
          event is! SmsChanged);
    });
    final debounceStream = events.where((event) {
      return (event is MobileChanged ||
          event is PasswordChanged ||
          event is SmsChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginModeChanged) {
      yield* _mapLoginModeChangedToState(event.loginMode);
    } else if (event is MobileChanged) {
      yield* _mapMobileChangedToState(event.mobile, event.loginMode);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password, event.loginMode);
    } else if (event is SmsChanged) {
      yield* _mapSmsChangedToState(event.sms, event.loginMode);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        mobile: event.mobile,
        password: event.password,
      );
    } else if (event is LoginWithSmsPressed) {
      yield* _mapLoginWithSmsPressedToState(
        mobile: event.mobile,
        sms: event.sms,
      );
    }
  }

  Stream<LoginState> _mapLoginModeChangedToState(LoginMode loginMode) async* {
    yield state.update(loginMode: loginMode);
  }

  Stream<LoginState> _mapMobileChangedToState(
      String mobile, LoginMode loginMode) async* {
    yield state.update(
      isMobileValid: Validators.isValidMobile(mobile),
      loginMode: loginMode,
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(
      String password, LoginMode loginMode) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
      loginMode: loginMode,
    );
  }

  Stream<LoginState> _mapSmsChangedToState(
      String sms, LoginMode loginMode) async* {
    yield state.update(
      isSmsValid: Validators.isValidSms(sms),
      loginMode: loginMode,
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String mobile,
    String password,
  }) async* {
    yield LoginState.loading();
    LoginMode loginMode = LoginMode.PASSWORD;
    try {
      ResponseEntity responseEntity =
          await _userRepository.signInWithCredentials(mobile, password);
      if (responseEntity?.code == Codes.SUCCESS) {
        String token = jsonEncode(responseEntity.data);
        await _userRepository.persistToken(token);
        yield LoginState.success(loginMode);
      } else {
        yield LoginState.failure(loginMode, responseEntity.message);
      }
    } catch (e) {
      yield LoginState.failure(loginMode, e);
    }
  }

  Stream<LoginState> _mapLoginWithSmsPressedToState({
    String mobile,
    String sms,
  }) async* {
    LoginMode loginMode = LoginMode.SMS;
    try {
      ResponseEntity responseEntity =
          await _userRepository.signInWithSms(mobile, sms);
      if (responseEntity?.code == Codes.SUCCESS) {
        String token = jsonEncode(responseEntity.data);
        await _userRepository.persistToken(token);
        yield LoginState.success(loginMode);
      } else {
        yield LoginState.failure(loginMode, responseEntity.message);
      }
    } catch (e) {
      yield LoginState.failure(loginMode, e);
    }
  }
}
