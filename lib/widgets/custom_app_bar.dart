import 'package:flutter/material.dart';

Widget buildCustomAppBar(
  BuildContext context,
  String title,
  String leadingIcon,
  String action1Icon,
  String action2Icon,
  VoidCallback leadingOnPressed,
  VoidCallback action1OnPressed,
  VoidCallback action2OnPressed,
  VoidCallback closeMoreAppBar,
) {
  return AppBar(
    elevation: 0.0,
    leading: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: ImageIcon(
        AssetImage(leadingIcon),
        color: Colors.white,
      ),
      onPressed: leadingOnPressed,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    centerTitle: true,
    flexibleSpace: Stack(
      children: <Widget>[
        Positioned(
          top: 10.0,
          left: 20.0,
          child: Image.asset(
            'assets/images/common/icons/bar/hat.png',
            width: 36.0,
          ),
        ),
      ],
    ),
    actions: <Widget>[
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: ImageIcon(
          AssetImage(action1Icon),
          color: Colors.white,
        ),
        onPressed: () {
          if (closeMoreAppBar != null) closeMoreAppBar();
          if (action1OnPressed != null) action1OnPressed();
        },
      ),
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: ImageIcon(
          AssetImage(action2Icon),
          color: Colors.white,
        ),
        onPressed: () {
          if (closeMoreAppBar != null) closeMoreAppBar();
          if (action2OnPressed != null) action2OnPressed();
        },
      ),
    ],
  );
}

Widget buildChildCustomAppBar(
  BuildContext context,
  String title,
  String action1Icon,
  VoidCallback action1OnPressed,
) {
  List<Widget> actions = [];
  if (action1Icon != null) {
    actions.add(IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: ImageIcon(
        AssetImage(action1Icon),
        color: Colors.white,
      ),
      onPressed: action1OnPressed,
    ));
  }
  return AppBar(
    elevation: 0.0,
    leading: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: ImageIcon(
        AssetImage('assets/images/common/icons/bar/back.png'),
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    centerTitle: true,
    flexibleSpace: Stack(
      children: <Widget>[
        Positioned(
          top: 5.0,
          left: 20.0,
          child: Image.asset(
            'assets/images/common/icons/bar/hat.png',
            width: 36.0,
          ),
        ),
      ],
    ),
    actions: actions,
  );
}
