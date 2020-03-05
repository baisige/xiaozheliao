import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xiaozheliao/app/ticker.dart';
import 'package:xiaozheliao/blocs/auth/auth_bloc.dart';
import 'package:xiaozheliao/blocs/auth/auth_event.dart';
import 'package:xiaozheliao/blocs/login/login_bloc.dart';
import 'package:xiaozheliao/blocs/login/login_event.dart';
import 'package:xiaozheliao/blocs/login/login_state.dart';
import 'package:xiaozheliao/blocs/sms/sms_bloc.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/widgets/account/register_edit_button.dart';
import 'package:xiaozheliao/screens/account/edit_password_screen.dart';
import 'package:xiaozheliao/screens/account/register_screen.dart';
import 'package:xiaozheliao/widgets/account/send_sms_text_field.dart';
import 'package:xiaozheliao/widgets/account/submit_button.dart';
import 'package:xiaozheliao/widgets/account/toggle_login_mode.dart';

import 'form_text_field.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  final PageController _controller;
  final LoginMode _loginMode;

  LoginForm(
      {Key key,
      @required UserRepository userRepository,
      @required PageController controller,
      LoginMode loginMode})
      : assert(userRepository != null),
        assert(controller != null),
        _userRepository = userRepository,
        _controller = controller,
        _loginMode = loginMode ?? LoginMode.PASSWORD,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

enum LoginMode { PASSWORD, SMS }

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  PageController get _controller => widget._controller;

  bool get mode => widget._loginMode == LoginMode.PASSWORD;

  String get _title => mode ? '手机密码登录' : '手机验证登录';

  String get _subTitle => mode ? '手机验证登录' : '手机密码登录';

  TextEditingController _mobileController, _passwordController, _smsController;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _mobileController = TextEditingController();
    _smsController = TextEditingController();
    _passwordController = TextEditingController();

    _mobileController.addListener(_onMobileChanged);
    _smsController.addListener(_onSmsChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _mobileController?.dispose();
    _passwordController?.dispose();
    _smsController?.dispose();
    super.dispose();
  }

  bool isLoginButtonEnabled(LoginState state) {
    bool isPopulated = false;
    String mobile = _mobileController.text;
    bool isFormValid = false;
    if (state.loginMode == LoginMode.PASSWORD) {
      isPopulated = mobile.isNotEmpty && _passwordController.text.isNotEmpty;
      isFormValid = state.isPasswordFormValid;
    } else {
      isPopulated = mobile.isNotEmpty && _smsController.text.isNotEmpty;
      isFormValid = state.isSmsFormValid;
    }
    return isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    Widget loginModeWidget;
    if (mode) {
      loginModeWidget = FormTextField(
        image: 'assets/images/account/icons/lock.png',
        hintText: '请输入密码',
        controller: _passwordController,
        keyboardType: TextInputType.text,
        vertical: 5.0,
        obscureText: true,
      );
    } else {
      loginModeWidget = BlocProvider(
        create: (context) => SmsBloc(
          ticker: Ticker(),
          userRepository: _userRepository,
        ),
        child: SendSmsTextField(
          vertical: 5.0,
          controller: _smsController,
          mobileController: _mobileController,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Fluttertoast.showToast(
            msg: state.message,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: <Widget>[
                    ToggleLoginMode(
                      title: _title,
                      subTitle: _subTitle,
                      onTap: toggleLoginMode,
                    ),
                    SizedBox(height: 16.0),
                    FormTextField(
                      image: 'assets/images/account/icons/mobile.png',
                      hintText: '请输入手机号',
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      vertical: 5.0,
                    ),
                    SizedBox(height: 16.0),
                    loginModeWidget,
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.only(top: 37.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                      SubmitButton(
                        text: '登录',
                        onPressed:
                            isLoginButtonEnabled(state) ? _loginSubmitted : null,
                      ),
                    SizedBox(height: 8.0),
                    RegisterEditButton(
                      registerOnTap: _registerOnTap,
                      editOnTap: _editOnTap,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void toggleLoginMode() {
    _loginBloc.add(
        LoginModeChanged(loginMode: mode ? LoginMode.SMS : LoginMode.PASSWORD));
    _controller.animateToPage(mode ? 1 : 0,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _onMobileChanged() {
    _loginBloc.add(
      MobileChanged(
        mobile: _mobileController.text,
        loginMode: widget._loginMode,
      ),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(
        password: _passwordController.text,
        loginMode: widget._loginMode,
      ),
    );
  }

  void _onSmsChanged() {
    _loginBloc.add(
      SmsChanged(
        sms: _smsController.text,
        loginMode: widget._loginMode,
      ),
    );
  }

  void _loginSubmitted() {
    var mobile = _mobileController.text.trim();
    if (widget._loginMode == LoginMode.PASSWORD) {
      _loginBloc.add(
        LoginWithCredentialsPressed(
          mobile: mobile,
          password: _passwordController.text.trim(),
        ),
      );
    } else {
      _loginBloc.add(
        LoginWithSmsPressed(
          mobile: mobile,
          sms: _smsController.text.trim(),
        ),
      );
    }
  }

  void _registerOnTap() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => RegisterScreen(
          userRepository: _userRepository,
        ),
      ),
    );
  }

  void _editOnTap() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => EditPasswordScreen(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}
