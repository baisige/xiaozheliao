import 'package:flutter/material.dart';

class LTBackButton extends StatelessWidget {
  const LTBackButton({this.onBackPressed, this.size, this.color});

  final VoidCallback onBackPressed;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: ImageIcon(
        AssetImage('assets/images/common/icons/bar/back.png'),
        size: size ?? 24.0,
        color: color,
      ),
      onPressed: () {
        if (onBackPressed != null) {
          onBackPressed();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
