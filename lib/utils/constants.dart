import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/views/widgets/drawer_navigation_item_model.dart';

List<String> userRoles = ['admin', 'coach', 'client'];

const TextStyle titleHomeStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

TextStyle get titleStyle {
  return GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black));
}

TextStyle get subtitleStyle {
  return GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade400));
}

const List<dynamic> navigationItems = <DrawerNavigationItemModel>[
  DrawerNavigationItemModel(
      label: 'Sesiones',
      icon: Icon(Icons.calendar_month_outlined),
      selectedIcon: Icon(Icons.calendar_month_outlined)),
  DrawerNavigationItemModel(
      label: 'Perfil',
      icon: Icon(Icons.person),
      selectedIcon: Icon(Icons.person)),
  DrawerNavigationItemModel(
      label: 'Ajustes',
      icon: Icon(Icons.settings),
      selectedIcon: Icon(Icons.settings)),
];
