import 'package:flutter/material.dart';

class SettingsItem {
  final String title;
  final Widget subTitle;
  final VoidCallback onTap;

  SettingsItem({String title, Widget subTitle, VoidCallback onTap})
      : title = title,
        subTitle = subTitle,
        onTap = onTap;
}
