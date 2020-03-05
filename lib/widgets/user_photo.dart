import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  final String _photo;
  final double _size;
  final VoidCallback _onTap;

  const UserPhoto({Key key, String photo, double size, VoidCallback onTap})
      : assert(size != null && size >= 0.0),
        _photo = photo,
        _size = size,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String photo = _photo ?? 'assets/images/common/photo.png';
    Widget image;
    if (photo.startsWith('http')) {
      image = Image.network(photo, width: _size);
    } else {
      image = Image.asset(photo, width: _size);
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: ClipOval(child: image),
      onTap: _onTap,
    );
  }
}
