import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:my_trainer/common/screens/home_screen.dart';
import '../../data/repositories/firestore.dart';
import '../../data/repositories/user_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              GoogleProvider(
                  clientId:
                      "562156118846-mogb1s391muu1vs8bi33hph9i2m7jrep.apps.googleusercontent.com"),
              EmailAuthProvider(),
            ],
          );
        }

        checkIfUserExists(snapshot.data!.uid).then((exists) {
          print(exists);
          if (exists) {
            return const HomeScreen();
          }

          UserRepository().addUser(
            snapshot.data!.uid,
            {
              'uid': snapshot.data!.uid,
              'email': snapshot.data!.email,
              'displayName': snapshot.data!.displayName,
              'role': 'client',
            },
          );
        });
        return const HomeScreen();
      },
    );
  }
}

Future<bool> checkIfUserExists(String uid) async {
  var user = await FirestoreRepository().getDocument('users', uid);
  if (user.exists) {
    return true;
  }
  return false;
}
