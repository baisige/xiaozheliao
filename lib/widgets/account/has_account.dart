import 'package:flutter/cupertino.dart';
import 'package:xiaozheliao/utils/xzl_colors.dart';

class HasAccount extends StatelessWidget {
  final VoidCallback _onTap;

  const HasAccount({
    Key key,
    @required VoidCallback onTap,
  })  : assert(onTap != null),
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '已有账号',
              style: TextStyle(
                color: XzlColors.ff53cac3,
                fontSize: 16.0,
              ),
            ),
          ),
          onTap: _onTap,
        ),
      ],
    );
  }
}
