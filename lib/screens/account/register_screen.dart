import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/login/bloc.dart';
import 'package:xiaozheliao/blocs/register/bloc.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/widgets/account/register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/account/bg.png'),
              Expanded(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<RegisterBloc>(
                      create: (BuildContext context) =>
                          RegisterBloc(userRepository: _userRepository),
                    ),
                    BlocProvider<LoginBloc>(
                      create: (BuildContext context) =>
                          LoginBloc(userRepository: _userRepository),
                    ),
                  ],
                  child: RegisterForm(
                    userRepository: _userRepository,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
