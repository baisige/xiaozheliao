import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/guide/active_step.dart';
import 'package:xiaozheliao/widgets/guide/next_step.dart';

class Step2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/guide/step2.png'),
          Text(
            '优质信息',
            style: TextStyle(
              color: XzlColors.ff53cac3,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            '丰富资源 轻松查找',
            style: TextStyle(
              color: XzlColors.ff666666,
            ),
          ),
          SizedBox(height: 56.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NextStep(),
              SizedBox(width: 18.0),
              ActiveStep(),
              SizedBox(width: 18.0),
              NextStep(),
            ],
          ),
        ],
      ),
    );
  }
}
