import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/login/login_bloc.dart';
import 'package:xiaozheliao/blocs/login/login_event.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/account/password_login_screen.dart';
import 'package:xiaozheliao/screens/account/sms_login_screen.dart';
import 'package:xiaozheliao/widgets/account/login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: [
          PasswordLoginScreen(
            userRepository: _userRepository,
            controller: controller,
          ),
          SmsLoginScreen(
            userRepository: _userRepository,
            controller: controller,
          ),
        ],
        onPageChanged: (index) => _loginModeChanged(
          BlocProvider.of<LoginBloc>(context),
          index,
        ),
      ),
    );
  }

  void _loginModeChanged(LoginBloc loginBloc, int index) {
    switch (index) {
      case 0:
        loginBloc.add(
          LoginModeChanged(
            loginMode: LoginMode.PASSWORD,
          ),
        );
        break;
      case 1:
        loginBloc.add(
          LoginModeChanged(
            loginMode: LoginMode.SMS,
          ),
        );
        break;
    }
  }
}
