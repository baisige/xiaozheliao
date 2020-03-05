import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/guide/active_step.dart';
import 'package:xiaozheliao/widgets/guide/next_step.dart';

class Step1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/guide/step1.png'),
          Text(
            '极简聊天',
            style: TextStyle(
              color: XzlColors.ff53cac3,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '简洁界面 舒适聊天',
            style: TextStyle(
              color: XzlColors.ff666666,
            ),
          ),
          SizedBox(height: 56.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ActiveStep(),
              SizedBox(width: 18.0),
              NextStep(),
              SizedBox(width: 18.0),
              NextStep(),
            ],
          ),
        ],
      ),
    );
  }
}
