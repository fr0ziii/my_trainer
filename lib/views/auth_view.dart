import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/auth_view_model.dart';

class AuthView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro / Inicio de Sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Correo electrónico',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) => Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      authViewModel.signUp(_emailController.text.trim(),
                          _passwordController.text.trim());
                    },
                    child: const Text('Registrarse'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authViewModel.signIn(_emailController.text.trim(),
                          _passwordController.text.trim());
                    },
                    child: const Text('Iniciar Sesión'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authViewModel.signOut();
                    },
                    child: const Text('Cerrar Sesión'),
                  ),
                  if (authViewModel.errorMessage != null)
                    Text(
                      authViewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: MaterialApp(
        home: AuthView(),
      ),
    ),
  );
}
