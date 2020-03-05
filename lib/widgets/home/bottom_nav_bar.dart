import 'package:flutter/material.dart';

import 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatefulWidget {
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double elevation;
  final double iconSize;
  final double fontSize;
  final Color selectedColor;
  final Color unselectedColor;

  const BottomNavBar(
      {Key key,
      this.items,
      this.onTap,
      this.currentIndex = 0,
      this.elevation = 4.0,
      this.iconSize = 24.0,
      this.fontSize = 12.0,
      this.selectedColor,
      this.unselectedColor})
      : assert(items != null),
        assert(elevation != null && elevation >= 0.0),
        assert(iconSize != null && iconSize >= 0.0),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNavBarState();
  }
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> barItems = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      bool selected = widget.currentIndex == i;
      BottomNavBarItem item = widget.items[i];
      String icon = selected ? item.activeIcon : item.icon;
      Color color = selected ? widget.selectedColor : widget.unselectedColor;
      barItems.add(
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage(icon),
                  size: widget.iconSize,
                  color: color,
                ),
                SizedBox(height: 1.0),
                Text(
                  item.title,
                  style: TextStyle(
                    color: color,
                    fontSize: widget.fontSize,
                  ),
                ),
              ],
            ),
            onTap: () {
              if (widget.onTap != null) widget.onTap(i);
            },
          ),
        ),
      );
    }

    return Material(
      elevation: widget.elevation,
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: barItems,
        ),
      ),
    );
  }
}
