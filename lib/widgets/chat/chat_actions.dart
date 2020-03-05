import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/home/bottom_nav_bar_item.dart';

class ChatActions extends StatelessWidget {
  final List<BottomNavBarItem> items = <BottomNavBarItem>[
    BottomNavBarItem(
      icon: 'assets/images/chat/more/picture.png',
      title: '图片',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/chat/more/camera.png',
      title: '拍摄',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/chat/more/contacts.png',
      title: '联系人',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/chat/more/file.png',
      title: '文件',
      //backgroundColor: Colors.orange
    ),
    BottomNavBarItem(
      icon: 'assets/images/chat/more/favorite.png',
      title: '收藏',
      //backgroundColor: Colors.orange
    ),
  ];

  final ValueChanged<int> onTap;
  final int actionIndex;
  final double iconSize;
  final double fontSize;

  ChatActions(
      {Key key,
      this.onTap,
      this.actionIndex = 0,
      this.iconSize = 40.0,
      this.fontSize = 14.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> moreItems = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      moreItems.add(
        Padding(
          padding: EdgeInsets.only(left: 30.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: ImageIcon(
                  AssetImage(items[i].icon),
                  size: iconSize,
                  color: XzlColors.ff53cac3,
                ),
                onTap: () {
                  if (onTap != null) onTap(i);
                },
              ),
              Text(
                items[i].title,
                style: TextStyle(
                  color: XzlColors.ff333333,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 116.0,
      padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: 20.0),
        physics: ClampingScrollPhysics(),
        children: moreItems,
      ),
    );
  }
}
