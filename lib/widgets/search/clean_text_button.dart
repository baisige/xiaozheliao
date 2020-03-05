import 'package:flutter/material.dart';

class CleanTextButton extends StatelessWidget {
  final Color color;
  final double size;
  final bool visible;
  final VoidCallback onPressed;

  const CleanTextButton({
    Key key,
    this.color,
    this.size,
    this.visible,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? false,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.only(top: 4.0),
        icon: ImageIcon(
          AssetImage('assets/images/common/icons/bar/clean.png'),
          size: size ?? 24.0,
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
