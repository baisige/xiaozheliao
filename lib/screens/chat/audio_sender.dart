import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class AudioSender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: ImageIcon(
              AssetImage('assets/images/chat/audio.png'),
              size: 24.0,
              color: XzlColors.ff666666,
            ),
          ),
          onTap: () {
            print('object1');
          },
        ),
        Visibility(
          visible: false,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/chat/audio/wave.png',
                              width: 24.0,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              '00\' 00"',
                              style: TextStyle(
                                color: XzlColors.ff53cac3,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/chat/audio/send.png',
                          width: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '按住讲话',
                    style: TextStyle(
                      color: XzlColors.ff666666,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      'assets/images/chat/audio/sound-record.png',
                      height: 42.0,
                    ),
                  ),
                  onTap: () {
                    print('object');
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '录音',
                  style: TextStyle(
                    color: XzlColors.ff999999,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
