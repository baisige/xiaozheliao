import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xiaozheliao/blocs/auth/auth_bloc.dart';
import 'package:xiaozheliao/blocs/auth/auth_event.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class Step3Screen extends StatelessWidget {
  final UserRepository _userRepository;

  Step3Screen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildExperienceNow() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 80.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: XzlColors.ff53cac3,
              borderRadius: BorderRadius.circular(20.0)),
          child: Text(
            '立即体验',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(Experienced());
        },
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/guide/step3.png'),
          Text(
            '个性推荐',
            style: TextStyle(
              color: XzlColors.ff53cac3,
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '老友推荐 畅快嗨皮',
            style: TextStyle(
              color: XzlColors.ff666666,
            ),
          ),
          SizedBox(height: 50.0),
          BlocProvider(
            create: (context) {
              return AuthBloc(
                userRepository: _userRepository,
              );
            },
            child: _buildExperienceNow(),
          ),
        ],
      ),
    );
  }
}
