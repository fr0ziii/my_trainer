import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bienvenido,',
                              style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold)),
                          Text('Cliente', style: TextStyle(fontSize: 18, color: Colors.grey.shade800, fontWeight: FontWeight.bold)),
                          Visibility(
                            visible: authViewModel.currentUserModel?.role == 'trainer',
                            child: Text('Código de invitación: ${authViewModel.currentUserModel?.invitationCode ?? ''}',
                                style: TextStyle(color: Colors.grey[400])),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mi calendario',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                        Visibility(
                          visible: authViewModel.currentUserModel?.role == 'trainer',
                          child: Text('Código de invitación: ${authViewModel.currentUserModel?.invitationCode ?? ''}',
                              style: TextStyle(color: Colors.grey[400])),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mis sesiones',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                        Visibility(
                          visible: authViewModel.currentUserModel?.role == 'trainer',
                          child: Text('Código de invitación: ${authViewModel.currentUserModel?.invitationCode ?? ''}',
                              style: TextStyle(color: Colors.grey[400])),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mis pagos',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
