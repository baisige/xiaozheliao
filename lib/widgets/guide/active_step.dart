import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class ActiveStep extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.0,
      height: 2,
      decoration: BoxDecoration(
        color: XzlColors.ff53cac3,
        borderRadius: BorderRadius.circular(1.0),
      ),
    );
  }
}