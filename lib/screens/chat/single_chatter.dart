import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';
import 'package:xiaozheliao/widgets/user_photo.dart';

import 'message_sender.dart';

class SingleChatter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SingleChatterState();
  }

}

class SingleChatterState extends State<SingleChatter>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Container(
            color: XzlColors.ffececec,
            child: GestureDetector(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserPhoto(
                          photo: null,
                          size: 44.0,
                          onTap: () {},
                        ),
                        SizedBox(width: 12.0),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              top: 8.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              '''各位谢朋友！''',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                        SizedBox(width: 44.0),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                print('object');
              },
            ),
          ),
        ),
        MessageSender(),
      ],
    );
  }

}