import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  String? errorMessage;

  User? get currentUser => _authService.currentUser;

  Future<void> signUp(String email, String password) async {
    try {
      String? userId = await _authService.register(email, password);
      if (userId != null) {
        // Registro exitoso, puedes realizar acciones adicionales aquí si es necesario
      } else {
        errorMessage = 'Error en el registro';
      }
    } catch (e) {
      errorMessage = 'Error en el registro: $e';
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      String? userId =
          await _authService.signInWithEmailAndPassword(email, password);
      if (userId != null) {
        // Inicio de sesión exitoso, puedes navegar a la pantalla principal
      } else {
        errorMessage = 'Error en el inicio de sesión';
      }
    } catch (e) {
      errorMessage = 'Error en el inicio de sesión: $e';
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    // Puedes realizar acciones adicionales después de cerrar sesión si es necesario
    notifyListeners();
  }

}
