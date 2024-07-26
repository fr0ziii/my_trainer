import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/views/widgets/drawer_navigation_item_model.dart';

List<String> userRoles = ['admin', 'trainer', 'client'];

const TextStyle titleHomeStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

TextStyle get appTitleStyle {
  return GoogleFonts.aBeeZee(
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black));
}

TextStyle get titleStyle {
  return GoogleFonts.aBeeZee(
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black));
}

TextStyle get subtitleStyle {
  return GoogleFonts.aBeeZee(
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade600));
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
  DrawerNavigationItemModel(
      label: 'Quiero ser entrenador',
      icon: Icon(Icons.account_box),
      selectedIcon: Icon(Icons.account_box)),
];


final Map<String, Color> sessionTypeColors = {
  'Fisioterapia': Colors.green.shade200,
  'Entrenamiento personal': Colors.blue.shade200,
  'Crossfit': Colors.red.shade200,
  'Yoga': Colors.purple.shade200,
  'Boxeo': Colors.orange.shade200,
};
