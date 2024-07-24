import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../view_models/auth_view_model.dart';


class BottomNavbar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const BottomNavbar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: GNav(
            color: Colors.grey.shade400,
            backgroundColor: Colors.white,
            gap: 4,
            activeColor: Colors.grey.shade800,
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 20,
            iconSize: 20,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            tabBackgroundColor: Colors.grey.shade100,
            onTabChange: (value) => onTabChange!(value),
            tabs: [
              GButton(
                icon: Icons.home,
                text: ' Inicio',
              ),
              GButton(
                icon: Icons.calendar_month_outlined,
                text: 'Agenda',
              ),
              authViewModel.currentUserModel?.role == 'trainer'
                  ? GButton(
                      icon: Icons.people,
                      text: 'Clientes',
                    )
                  : GButton(
                      icon: Icons.person,
                      text: 'Mis clientes',
                    ),
              authViewModel.currentUserModel?.role == 'trainer'
                  ? GButton(
                      icon: Icons.wallet,
                      text: 'Pagos',
                    )
                  : GButton(
                      icon: Icons.payment,
                      text: 'Mis servicios',
                    ),
            ]));
  }
}
