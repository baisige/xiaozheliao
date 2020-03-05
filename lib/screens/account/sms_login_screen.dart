import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/login/login_bloc.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/widgets/account/login_form.dart';

class SmsLoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final PageController _controller;

  SmsLoginScreen(
      {Key key,
      @required UserRepository userRepository,
      @required PageController controller})
      : assert(userRepository != null),
        assert(controller != null),
        _userRepository = userRepository,
        _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/account/bg.png'),
            Expanded(
              child: BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
                child: LoginForm(
                  userRepository: _userRepository,
                  controller: _controller,
                  loginMode: LoginMode.SMS,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
