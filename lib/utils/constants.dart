import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import '/views/widgets/drawer_navigation_item_model.dart';

List<String> userRoles = ['admin', 'coach', 'client'];

const TextStyle titleHomeStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

const List<dynamic> navigationItems = <DrawerNavigationItemModel>[
  DrawerNavigationItemModel(
      label: 'Calendario',
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
