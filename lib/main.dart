import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_trainer/view_models/auth_view_model.dart';
import 'package:my_trainer/views/home_screen.dart';
import 'package:my_trainer/views/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyTrainer',
      theme: ThemeData(
        fontFamily: 'Roboto',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconSize: 28,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      locale: const Locale('es'),
      home: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          if (authViewModel.currentUser != null) {
            return const HomeScreen(); // Reemplaza con tu pantalla principal
          } else {
            return const LoginScreen(); // Reemplaza con tu pantalla de inicio de sesión
          }
        },
      ),
    );
  }
}
