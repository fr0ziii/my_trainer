import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



import '/view_models/auth_view_model.dart';
import '/views/home_screen.dart';
import '/views/login_screen.dart';


import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  Stripe.merchantIdentifier = "Test";
  await Stripe.instance.applySettings();

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
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const EsLocalizations()),
        FirebaseUILocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'ES')],
      title: 'MyTrainer',
      theme: ThemeData(
        primaryColor: Colors.blue.shade400,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconSize: 28,
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      locale: const Locale('es', 'ES'),
      home: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          if (authViewModel.currentUser != null) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
