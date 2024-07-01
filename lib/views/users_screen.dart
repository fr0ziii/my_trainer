import 'package:flutter/material.dart';

import '../utils/constants.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.blue[100],
        shadowColor: Colors.black,
        title: Text('Usuarios', style: appTitleStyle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Text('Lista de usuarios', style: titleStyle),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
