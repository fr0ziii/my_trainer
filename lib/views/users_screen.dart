import 'package:flutter/material.dart';
import 'package:my_trainer/services/user_service.dart';
import 'package:my_trainer/views/widgets/input_field.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';
import '../view_models/auth_view_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserService _userService = UserService();
  List<UserModel> _users = [];
  late Future<void> _initialLoad;

  @override
  void initState() {
    super.initState();
    _initialLoad = _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final user = await authViewModel.getCurrentUser();
    if (user != null) {
      _loadUsers(user.trainerId);
    }
  }

  Future<void> _loadUsers(String userId) async {
    _userService.getUsersByTrainer(userId).listen((users) {
      setState(() {
        _users = users;
      });
    });
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUserDialog();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        shadowColor: Colors.black,
        title: Text('Clientes', style: appTitleStyle),

      ),
      body: FutureBuilder<void>(
        future: _initialLoad,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade200,
                    child: Text(_users[index].displayName?.substring(0, 1) ?? ''),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  title: Text(_users[index].displayName ?? 'Sin nombre asignado'),
                  subtitle: Text(_users[index].email),
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: _showAddUserDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  String? _selectedOption;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir cliente', style: appTitleStyle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('¿Cómo quieres añadir a tu cliente a la plataforma?', style: subtitleStyle),
          SizedBox(height: 20),
          DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            underline: Container(),
            value: _selectedOption,
            hint: Text('Selecciona una opción'),
            items: [
              DropdownMenuItem(
                value: 'invite_no_plan',
                child: Text('Enviar invitación sin plan de pago asignado', style: titleStyle),
              ),
              DropdownMenuItem(
                value: 'invite_plan',
                child: Text('Enviar invitación con plan de pago asignado', style: titleStyle),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
          ),
          if (_selectedOption == 'invite_plan' || _selectedOption == 'invite_no_plan') ...[
            InputField(label: 'Nombre', hint: '', controller: _nameController),
            InputField(label: 'Correo electrónico', hint: '', controller: _emailController),
          ],
          if (_selectedOption == 'invite_plan') ...[
            InputField(label: 'Plan asignado', hint: '', controller: _emailController),
          ]
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}