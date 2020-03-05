import 'package:flutter/material.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class FormTextField extends StatelessWidget {
  final String _image;
  final String _hintText;
  final double _vertical;
  final TextEditingController _controller;
  final TextInputType _keyboardType;
  final bool _obscureText;

  FormTextField({
    Key key,
    @required String image,
    @required String hintText,
    @required double vertical,
    @required TextEditingController controller,
    @required TextInputType keyboardType,
    bool obscureText,
  })  : assert(image != null),
        assert(hintText != null),
        assert(controller != null),
        _image = image,
        _hintText = hintText,
        _vertical = vertical ?? 8.0,
        _controller = controller,
        _keyboardType = keyboardType,
        _obscureText = obscureText ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          '$_image',
          width: 20.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: _vertical,
            ),
            margin: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: XzlColors.ffdddddd),
              ),
            ),
            child: TextField(
              controller: _controller,
              keyboardType: _keyboardType,
              obscureText: _obscureText,
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '$_hintText',
                hintStyle: TextStyle(
                  color: XzlColors.ff999999,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
