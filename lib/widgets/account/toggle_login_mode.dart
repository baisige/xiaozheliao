import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class ToggleLoginMode extends StatelessWidget {
  final String _title;
  final String _subTitle;
  final VoidCallback _onTap;

  const ToggleLoginMode({Key key, onTap, title, subTitle})
      : _title = title,
        _subTitle = subTitle,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '$_title',
          style: TextStyle(
            color: XzlColors.ff666666,
            fontSize: 20.0,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Text(
            '$_subTitle',
            style: TextStyle(
              color: XzlColors.ff53cac3,
              fontSize: 16.0,
            ),
          ),
          onTap: () => this._onTap(),
        ),
      ],
    );
  }
}
