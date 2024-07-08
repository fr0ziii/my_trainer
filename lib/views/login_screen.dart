import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../services/stripe_service.dart';
import '/utils/functions.dart';
import '/services/user_service.dart';
import 'home_screen.dart';

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

        UserService().checkIfUserExists(snapshot.data!.uid).then((exists) {
          if (!exists) {
            StripeService().createCustomer(snapshot.data!.email!).then((stripeCustomer) {
              UserService().addUser(
                snapshot.data!.uid,
                {
                  'uid': snapshot.data!.uid,
                  'email': snapshot.data!.email,
                  'displayName': snapshot.data!.displayName ?? 'Usuario',
                  'role': 'client',
                  'profilePictureUrl': snapshot.data!.photoURL,
                  'registrationDate': DateTime.now().toString(),
                  'trainerId': generateUniqueUid(snapshot.data!.uid),
                  'clientIds': [],
                  'invitationCode': generateUniqueInvitationCode(),
                  'availableSlots': 10,
                  'sessionIds': [],
                  'stripeCustomerId': stripeCustomer['id'],
                },
              );
            }).catchError((error) {
            });
          }
        });
        return const HomeScreen();
      },
    );
  }
}
