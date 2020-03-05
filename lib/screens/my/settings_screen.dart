import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/auth/auth_bloc.dart';
import 'package:xiaozheliao/blocs/auth/auth_event.dart';
import 'package:xiaozheliao/screens/my/settings_items.dart';
import 'package:xiaozheliao/widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  final Client _client;

  SettingsScreen({
    Key key,
    @required Client client,
  })  : assert(client != null),
        _client = client,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChildCustomAppBar(context, '设置', null, null),
      body: SettingsItems(
        onTap: (index) {
          switch (index) {
            case 5:
              _client.close();
              Navigator.pop(context);
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              break;
          }
        },
      ),
    );
  }
}
