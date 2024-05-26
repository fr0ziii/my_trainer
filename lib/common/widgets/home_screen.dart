import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<dynamic> destinations = <NavigationRailDestination>[
    NavigationRailDestination(
        label: Text('Profile'),
        icon: Icon(Icons.person),
        selectedIcon: Icon(Icons.person)),
    NavigationRailDestination(
        label: Text('Calendar'),
        icon: Icon(Icons.calendar_month_outlined),
        selectedIcon: Icon(Icons.calendar_month_outlined)),
    NavigationRailDestination(
        label: Text('Settings'),
        icon: Icon(Icons.settings),
        selectedIcon: Icon(Icons.settings)),
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavigationDrawer(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Inicio',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations.map(
            (destination) {
              return NavigationDrawerDestination(
                label: destination.label,
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
