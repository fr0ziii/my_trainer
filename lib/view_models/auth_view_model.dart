import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? get currentUser => _authService.currentUser;
  UserModel? get currentUserModel => _authService.currentUserModel;
  Stream<User?> get authStateChanges => _authService.authStateChanges;
  String? errorMessage;

  Future<UserModel?> getCurrentUser() async {
    return _authService.currentUserModel;
  }

  Future<void> signUp(String email, String password) async {
    try {
      String? userId = await _authService.register(email, password);
      if (userId == null) {
        errorMessage = 'Error en el registro';
      }
    } catch (e) {
      errorMessage = 'Error en el registro: $e';
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      String? userId = await _authService.signInWithEmailAndPassword(email, password);
      if (userId == null) {
        errorMessage = 'Error en el inicio de sesión';
      }
    } catch (e) {
      errorMessage = 'Error en el inicio de sesión: $e';
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
