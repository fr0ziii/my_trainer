import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNavbar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
        child: GNav(
            color: Colors.grey[400],
            activeColor: Colors.grey.shade900,
            tabBackgroundColor: Colors.grey.shade100,
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 20,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
          GButton(
            icon: Icons.home,
            text: ' Inicio',
          ),
          GButton(
            icon: Icons.calendar_month_outlined,
            text: ' Calendario',
          ),
        ]));
  }
}
