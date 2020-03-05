import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

import 'bottom_nav_bar_item.dart';

class AppBarMore extends StatelessWidget {
  final List<BottomNavBarItem> items = <BottomNavBarItem>[
    BottomNavBarItem(
      icon: 'assets/images/common/icons/barext/scan.png',
      title: '扫一扫',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/common/icons/barext/qrcode.png',
      title: '二维码',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/common/icons/barext/add-friends.png',
      title: '添加好友',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/common/icons/barext/group-chat.png',
      title: '群聊',
      //backgroundColor: Colors.orange
    ),
  ];

  final ValueChanged<int> onTap;
  final bool isMore;
  final double elevation;
  final int actionIndex;
  final double iconSize;
  final double fontSize;

  AppBarMore(
      {Key key,
      this.onTap,
      this.isMore = false,
      this.actionIndex = 0,
      this.elevation = 2.0,
      this.iconSize = 18.0,
      this.fontSize = 14.0})
      : assert(elevation != null && elevation >= 0.0),
        assert(iconSize != null && iconSize >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> moreItems = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      moreItems.add(
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageIcon(
                  AssetImage(items[i].icon),
                  size: iconSize,
                  color: XzlColors.ff53cac3,
                ),
                SizedBox(height: 1.0),
                Text(
                  items[i].title,
                  style: TextStyle(
                    color: XzlColors.ff333333,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
            onTap: () {
              if (onTap != null) onTap(i);
            },
          ),
        ),
      );
      if (i < items.length) {
        moreItems.add(
          VerticalDivider(
            width: 1.0,
            color: XzlColors.ff999999,
          ),
        );
      }
    }
    return Visibility(
      visible: isMore,
      child: Positioned(
        child: Material(
          elevation: 0.5,
          child: Container(
            padding: EdgeInsets.only(top: 18.0, bottom: 12.0),
            height: 72.0,
            color: Colors.white,
            child: Row(
              children: moreItems,
            ),
          ),
        ),
      ),
    );
  }
}
