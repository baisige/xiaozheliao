import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaozheliao/app/env.dart';
import 'package:xiaozheliao/screens/my/settings_item.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class SettingsItems extends StatelessWidget {
  final ValueChanged<int> onTap;
  final List<SettingsItem> items = [
    SettingsItem(
      title: '修改密码',
      subTitle: Image.asset(
        'assets/images/common/next.png',
        height: 16.0,
      ),
    ),
    SettingsItem(
      title: '消息通知',
      subTitle: Container(
        height: 26.0,
        width: 48.0,
        child: CupertinoSwitch(
          value: true,
          activeColor: XzlColors.ff53cac3,
          onChanged: (bool value) {},
        ),
      ),
    ),
    SettingsItem(
      title: '清理缓存',
      subTitle: Text(
        '3.4MB',
        style: TextStyle(
          fontSize: 16.0,
          color: XzlColors.ff666666,
        ),
      ),
    ),
    SettingsItem(
      title: '当前版本',
      subTitle: Text(
        version,
        style: TextStyle(
          fontSize: 16.0,
          color: XzlColors.ff666666,
        ),
      ),
    ),
    SettingsItem(
      title: '检查更新',
      subTitle: Image.asset(
        'assets/images/common/next.png',
        height: 16.0,
      ),
    ),
    SettingsItem(
      title: '退出登录',
      subTitle: Image.asset(
        'assets/images/common/next.png',
        height: 16.0,
      ),
    ),
  ];

  SettingsItems({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> settingsItems = [];
    for (int i = 0; i < items.length; i++) {
      settingsItems.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      items[i].title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    items[i].subTitle ?? Container(),
                  ],
                ),
                SizedBox(height: 15.0),
                Divider(height: 1.0),
              ],
            ),
          ),
          onTap: () {
            if (onTap != null) onTap(i);
          },
        ),
      );
    }
    return Column(children: settingsItems);
  }
}
