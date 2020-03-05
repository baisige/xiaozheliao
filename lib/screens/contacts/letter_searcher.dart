import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

final String letterTitle = '''ABCDEFGHIJKLMNOPQRSTUVWXYZ#''';

class LetterSearcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    final letters = letterTitle.split('');
    for (int i = 0; i < letters.length; i++) {
      items.add(
        GestureDetector(
          child: ClipOval(
            child: Container(
              height: 17.0,
              width: 17.0,
              alignment: Alignment.center,
//              color: i == 1 ? XzlColors.ff53cac3 : Colors.transparent,
              child: Text(
                letters[i],
//                style: TextStyle(
//                  color: i == 1 ? Colors.white : XzlColors.ff333333,
//                ),
              ),
            ),
          ),
          onTap: () {},
        ),
      );
    }
    return Positioned(
      top: -2.0,
      right: 10.0,
      child: Column(children: items),
    );
  }
}
