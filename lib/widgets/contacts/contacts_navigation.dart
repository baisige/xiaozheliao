import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class ContactsNavigation extends StatelessWidget {
  final List<String> items = ['常聊', '好友', '群聊', '新朋友'];
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double elevation;

  ContactsNavigation({
    Key key,
    this.onTap,
    this.currentIndex,
    this.elevation,
  })  : assert(elevation != null && elevation >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> navTabs = [];
    for (int i = 0; i < items.length; i++) {
      Color color = i == currentIndex ? XzlColors.ff53cac3 : XzlColors.ff666666;
      navTabs.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Text(
            items[i],
            style: TextStyle(
              color: color,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            if (onTap != null) onTap(i);
          },
        ),
      );
    }

    return Material(
      elevation: elevation,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(top: 13.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navTabs,
        ),
      ),
    );
  }
}
