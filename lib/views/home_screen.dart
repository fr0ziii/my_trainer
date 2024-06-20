import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trainer/utils/constants.dart';

import 'calendar/calendar_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  get user => FirebaseAuth.instance.currentUser;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  User user = FirebaseAuth.instance.currentUser!;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });

    if (screenIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CalendarScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Inicio',
              style: Theme.of(context).textTheme.titleSmall,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Welcome, ${user.displayName}', style: titleHomeStyle),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.calendar_month_outlined),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalendarScreen(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
