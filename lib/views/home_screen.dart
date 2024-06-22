import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trainer/utils/constants.dart';

import 'calendar/calendar_screen.dart';
import 'dashboard_screen.dart';
import 'widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  get user => FirebaseAuth.instance.currentUser;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  User user = FirebaseAuth.instance.currentUser!;

  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const DashboardScreen(),
    const CalendarScreen(),
    const CalendarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: NavigationDrawer(
        backgroundColor: Colors.grey[200],
        onDestinationSelected: navigateBottomBar,
        selectedIndex: _selectedIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Inicio',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ...navigationItems.map(
            (navigationItem) {
              return NavigationDrawerDestination(
                label: Text(navigationItem.label),
                icon: navigationItem.icon,
                selectedIcon: navigationItem.selectedIcon,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const SignOutButton(
            variant: ButtonVariant.text,
          ),
        ],
      ),
    );
  }
}
