import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class SkipAppBar extends StatelessWidget {
  final PageController controller;

  const SkipAppBar({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        right: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 48.0,
              height: 20.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: XzlColors.ffeeeeee,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '跳过',
                style: TextStyle(color: XzlColors.ff999999),
              ),
            ),
            onTap: () => controller.animateToPage(
              2,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }
}
