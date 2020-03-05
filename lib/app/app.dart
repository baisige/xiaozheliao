import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/app/theme.dart';
import 'package:xiaozheliao/blocs/auth/bloc.dart';
import 'package:xiaozheliao/blocs/login/login_bloc.dart';
import 'package:xiaozheliao/repositories/repositories.dart';
import 'package:xiaozheliao/screens/account/login_screen.dart';
import 'package:xiaozheliao/screens/screens.dart';
import 'package:xiaozheliao/widgets/widgets.dart';

import 'localization.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BlocLocalizations().appTitle,
      theme: XzlTheme.theme,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: _userRepository),
              child: LoginScreen(userRepository: _userRepository),
            );
          }
          if (state is Authenticated) {
            return HomeScreen(
              userRepository: _userRepository,
              auth: state.auth,
              user: state.user,
            );
          }
          if (state is AuthLoading) {
            return LoadingIndicator();
          }
          return GuideScreen(userRepository: _userRepository);
        },
      ),
    );
  }
}
