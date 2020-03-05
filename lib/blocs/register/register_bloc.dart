import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xiaozheliao/app/validators.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xiaozheliao/models/response_entity.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! NicknameChanged &&
          event is! MobileChanged &&
          event is! SmsChanged &&
          event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is NicknameChanged ||
          event is MobileChanged ||
          event is SmsChanged ||
          event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is NicknameChanged) {
      yield* _mapNicknameChangedToState(event.nickname);
    } else if (event is MobileChanged) {
      yield* _mapMobileChangedToState(event.mobile);
    } else if (event is SmsChanged) {
      yield* _mapSmsChangedToState(event.sms);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is TermsAgreed) {
      yield* _mapTermsArgeedToState(event.isAgree);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.nickname,
        event.mobile,
        event.sms,
        event.password,
      );
    }
  }

  Stream<RegisterState> _mapNicknameChangedToState(String nickname) async* {
    yield state.update(
      isNicknameValid: Validators.isValidNickname(nickname),
    );
  }

  Stream<RegisterState> _mapMobileChangedToState(String mobile) async* {
    yield state.update(
      isMobileValid: Validators.isValidMobile(mobile),
    );
  }

  Stream<RegisterState> _mapSmsChangedToState(String sms) async* {
    yield state.update(
      isSmsValid: Validators.isValidSms(sms),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapTermsArgeedToState(bool isAgree) async* {
    yield state.update(
      isAgree: isAgree,
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String nickname,
    String mobile,
    String sms,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      ResponseEntity responseEntity = await _userRepository.signUp(
        nickname: nickname,
        mobile: mobile,
        sms: sms,
        password: password,
      );
      if (responseEntity.code == Codes.SUCCESS) {
        yield RegisterState.success();
      } else {
        yield RegisterState.failure(responseEntity.message);
      }
    } catch (e) {
      yield RegisterState.failure(e);
    }
  }
}
