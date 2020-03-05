import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xiaozheliao/repositories/user/user_repository.dart';
import 'package:xiaozheliao/screens/guide/step_1_screen.dart';
import 'package:xiaozheliao/screens/guide/step_2_screen.dart';
import 'package:xiaozheliao/screens/guide/step_3_screen.dart';
import 'package:xiaozheliao/widgets/guide/skip_app_bar.dart';

class GuideScreen extends StatefulWidget {
  final UserRepository _userRepository;

  GuideScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GuideScreenState();
  }
}

class GuideScreenState extends State<GuideScreen> {
  final PageController controller = PageController();
  bool skipping = false;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                Step1Screen(),
                Step2Screen(),
                Step3Screen(userRepository: _userRepository),
              ],
              onPageChanged: (int index) {
                setState(() {
                  skipping = index == 2 ? true : false;
                });
              },
            ),
            Visibility(
              visible: !skipping,
              child: SafeArea(
                child: SkipAppBar(
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
