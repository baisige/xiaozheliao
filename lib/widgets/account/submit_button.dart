import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class SubmitButton extends StatelessWidget {
  final String _text;
  final VoidCallback _onPressed;

  SubmitButton({
    Key key,
    String text,
    VoidCallback onPressed,
  })  : _text = text,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: XzlColors.ff53cac3,
      textColor: Colors.white,
      splashColor: Colors.transparent,
      disabledColor: XzlColors.ffcfcfcf,
      disabledTextColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
      onPressed: _onPressed,
    );
  }
}
