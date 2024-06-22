import 'package:flutter/material.dart';

class DrawerNavigationItemModel {
  final String label;
  final Icon icon;
  final Icon selectedIcon;
  final VoidCallback? onPressed;

  const DrawerNavigationItemModel({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.onPressed,
  });
}