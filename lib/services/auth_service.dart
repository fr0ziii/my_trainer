import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trainer/services/user_service.dart';

import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  User? _user;
  UserModel? _userModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }


  User? get currentUser => _user;
  UserModel? get currentUserModel => _userModel;

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      UserService().getUser(user.uid).then((userModel) {
        _userModel = userModel;
      });
    }
    notifyListeners();
  }

  Future<String?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return _user!.uid;
    } catch (e) {
      return null;
    }
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return _user!.uid;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
