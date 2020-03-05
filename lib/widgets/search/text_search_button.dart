import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class TextSearchButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const TextSearchButton({Key key, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Text(
          '搜索',
          style: TextStyle(
            fontSize: 16.0,
            color: color,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
