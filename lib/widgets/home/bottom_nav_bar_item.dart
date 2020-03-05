import 'package:meta/meta.dart';

class BottomNavBarItem {
  const BottomNavBarItem({
    @required this.icon,
    this.title,
    String activeIcon,
  })  : activeIcon = activeIcon ?? icon,
        assert(icon != null);

  final String icon;
  final String title;
  final String activeIcon;
}
