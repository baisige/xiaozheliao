import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class RegisterEditButton extends StatelessWidget {
  final VoidCallback registerOnTap;
  final VoidCallback editOnTap;

  RegisterEditButton(
      {Key key,
      @required VoidCallback registerOnTap,
      @required VoidCallback editOnTap})
      : assert(registerOnTap != null),
        assert(editOnTap != null),
        registerOnTap = registerOnTap,
        editOnTap = editOnTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              '还没账号！立即注册',
              style: TextStyle(color: XzlColors.ff53cac3),
            ),
          ),
          onTap: registerOnTap,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              '忘记密码？',
              style: TextStyle(color: XzlColors.ff999999),
            ),
          ),
          onTap: editOnTap,
        ),
      ],
    );
  }
}
