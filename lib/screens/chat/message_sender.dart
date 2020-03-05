import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/chat/chat_actions.dart';

import 'audio_sender.dart';

class MessageSender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: false,
          child: ChatActions(
            onTap: (index) {
              print(index);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: XzlColors.ffeeeeee),
              bottom: BorderSide(color: XzlColors.ffeeeeee),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  cursorColor: XzlColors.ff333333,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '发信息...',
                    hintStyle: TextStyle(
                      color: XzlColors.ff999999,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ImageIcon(
                  AssetImage('assets/images/chat/emoji.png'),
                  size: 24.0,
                  color: XzlColors.ff666666,
                ),
                onTap: () {},
              ),
              SizedBox(width: 20.0),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ImageIcon(
                  AssetImage('assets/images/chat/more.png'),
                  size: 24.0,
                  color: XzlColors.ff666666,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        AudioSender(),
      ],
    );
  }
}
