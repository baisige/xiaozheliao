import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/models/user.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/my/settings_screen.dart';
import 'package:xiaozheliao/widgets/my/show_my_data.dart';
import 'package:xiaozheliao/widgets/my/my_options.dart';

class MyScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final User _user;
  final Client _client;

  MyScreen({
    Key key,
    @required UserRepository userRepository,
    @required User user,
    @required Client client,
  })  : assert(userRepository != null),
        assert(client != null),
        _userRepository = userRepository,
        _user = user,
        _client = client,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset('assets/images/my/bg.png'),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      '我的',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  ShowMyData(
                    userRepository: _userRepository,
                    user: _user,
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: MyOptions(
            onTap: (index) {
              switch (index) {
                case 4:
                  _linkSettingsScreen(context);
                  break;
              }
            },
          ),
        ),
      ],
    );
  }

  void _linkSettingsScreen(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => SettingsScreen(
          client: _client,
        ),
      ),
    );
  }
}
