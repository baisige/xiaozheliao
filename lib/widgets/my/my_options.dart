import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/home/bottom_nav_bar_item.dart';

class MyOptions extends StatelessWidget {
  final List<BottomNavBarItem> items = <BottomNavBarItem>[
    BottomNavBarItem(
      icon: 'assets/images/my/scan.png',
      title: '扫一扫',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/my/pictures.png',
      title: '美照',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/my/like.png',
      title: '我喜欢',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/my/friends-dynamic.png',
      title: '好友更新',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/my/settings.png',
      title: '设置',
      //backgroundColor: Colors.orange
    ),
  ];

  final ValueChanged<int> onTap;
  final double elevation;
  final int actionIndex;
  final double iconSize;
  final double fontSize;

  MyOptions(
      {Key key,
      this.onTap,
      this.actionIndex = 0,
      this.elevation = 2.0,
      this.iconSize = 32.0,
      this.fontSize = 14.0})
      : assert(elevation != null && elevation >= 0.0),
        assert(iconSize != null && iconSize >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> moreItems = <Widget>[];
    final List<Widget> rows = <Widget>[];

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
                SizedBox(height: 8.0),
                Text(
                  items[i].title,
                  style: TextStyle(
                    color: XzlColors.ff666666,
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
      bool isLast = items.length == (i + 1);
      if ((i + 1) % 3 == 0 || isLast) {
        if (isLast && items.length % 3 != 0) {
          moreItems.add(Expanded(child: Container()));
        }
        rows.add(
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Row(
              children: moreItems.sublist(0, moreItems.length),
            ),
          ),
        );
        rows.add(
          Divider(
            height: 1,
            color: XzlColors.ffeeeeee,
          ),
        );
        moreItems.clear();
      }
    }
    return Container(
      padding: EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
      child: Column(
        children: rows,
      ),
    );
  }
}
