import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trainer/utils/constants.dart';
import 'package:my_trainer/views/users_screen.dart';
import 'package:provider/provider.dart';

import '../view_models/auth_view_model.dart';
import 'calendar/calendar_screen.dart';
import 'dashboard_screen.dart';
import 'widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const DashboardScreen(),
    const CalendarScreen(),
    const UsersScreen(),
    //Pagos o mi subscripción
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
        backgroundColor: Colors.blue.shade200,
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
          onDestinationSelected: navigateBottomBar,
          selectedIndex: _selectedIndex,
          children: <Widget>[
            Container(
              height: 150,
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icon.png'),
            ),
            ...navigationItems.map(
                  (navigationItem) {
                return NavigationDrawerDestination(
                  label: Text(navigationItem.label, style: TextStyle(color: Colors.grey.shade900)),
                  icon: navigationItem.icon,
                  selectedIcon: navigationItem.selectedIcon,
                );
              },
            )
          ],
        )
    );
  }
}
