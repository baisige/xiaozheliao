import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xiaozheliao/app/ticker.dart';
import 'package:xiaozheliao/blocs/auth/auth_bloc.dart';
import 'package:xiaozheliao/blocs/auth/auth_event.dart';
import 'package:xiaozheliao/blocs/login/login_bloc.dart';
import 'package:xiaozheliao/blocs/login/login_event.dart' as login;
import 'package:xiaozheliao/blocs/login/login_state.dart';
import 'package:xiaozheliao/blocs/register/bloc.dart';
import 'package:xiaozheliao/blocs/register/register_bloc.dart';
import 'package:xiaozheliao/blocs/register/register_state.dart';
import 'package:xiaozheliao/blocs/sms/sms_bloc.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/widgets/account/send_sms_text_field.dart';
import 'package:xiaozheliao/widgets/account/submit_button.dart';
import 'package:xiaozheliao/widgets/account/terms.dart';

import 'form_text_field.dart';
import 'has_account.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  RegisterBloc _registerBloc;

  TextEditingController _nicknameController,
      _mobileController,
      _passwordController,
      _smsController;

  bool get isPopulated =>
      _nicknameController.text.isNotEmpty &&
      _mobileController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _smsController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _nicknameController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _smsController = TextEditingController();

    _nicknameController.addListener(_onNicknameChanged);
    _mobileController.addListener(_onMobileChanged);
    _smsController.addListener(_onSmsChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _nicknameController?.dispose();
    _mobileController?.dispose();
    _passwordController?.dispose();
    _smsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
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
              BlocProvider.of<LoginBloc>(context).add(
                login.LoginWithCredentialsPressed(
                  mobile: _mobileController.text.trim(),
                  password: _passwordController.text.trim(),
                ),
              );
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
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
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: <Widget>[
                    FormTextField(
                      image: 'assets/images/account/icons/nickname.png',
                      hintText: '请输入昵称',
                      vertical: 0.0,
                      controller: _nicknameController,
                      keyboardType: TextInputType.text,
                    ),
                    FormTextField(
                      image: 'assets/images/account/icons/mobile.png',
                      hintText: '请输入手机号',
                      vertical: 0.0,
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    BlocProvider(
                      create: (context) => SmsBloc(
                        ticker: Ticker(),
                        userRepository: widget._userRepository,
                      ),
                      child: SendSmsTextField(
                        vertical: 0.0,
                        controller: _smsController,
                        mobileController: _mobileController,
                      ),
                    ),
                    FormTextField(
                      image: 'assets/images/account/icons/lock.png',
                      hintText: '设置登录密码，为6-20位字母和数字组成',
                      vertical: 0.0,
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SubmitButton(
                      text: '注册',
                      onPressed: isRegisterButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                    ),
                    HasAccount(
                      onTap: () => Navigator.pop(context),
                    ),
                    SizedBox(height: 30.0),
                    Terms(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onNicknameChanged() {
    _registerBloc.add(
      NicknameChanged(
        nickname: _nicknameController.text,
      ),
    );
  }

  void _onMobileChanged() {
    _registerBloc.add(
      MobileChanged(
        mobile: _mobileController.text,
      ),
    );
  }

  void _onSmsChanged() {
    _registerBloc.add(
      SmsChanged(
        sms: _smsController.text,
      ),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        nickname: _nicknameController.text,
        mobile: _mobileController.text,
        sms: _smsController.text,
        password: _passwordController.text,
      ),
    );
  }
}
