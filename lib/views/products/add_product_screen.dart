import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_trainer/utils/constants.dart';
import 'package:uuid/uuid.dart';
import '../../models/product_model.dart';
import '../../services/auth_service.dart';
import '../../services/product_service.dart';
import '../widgets/input_field.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _sessionsPerWeekController = TextEditingController();
  final _durationInMonthsController = TextEditingController();
  final _currencyController = TextEditingController(text: 'EUR');
  final AuthService _authService = AuthService();
  final ProductService _productService = ProductService();


  void _createProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = ProductModel(
        id: Uuid().v4(),
        trainerId: _authService.currentUser!.uid,
        stripeId: '',
        priceId: '',
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        currency: _currencyController.text,
        sessionsPerWeek: int.parse(_sessionsPerWeekController.text),
        creationDate: DateTime.now(),
      );

      _productService.createProduct(product);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear subscripción', style: appTitleStyle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              InputField(label: 'Nombre de la subscripción', hint: '', controller: _nameController),
              InputField(label: 'Descripción', hint: '', controller: _descriptionController),
              InputField(label: 'Precio (€)', hint: '', controller: _priceController, keyboardType: TextInputType.number),
              InputField(label: 'Sesiones por semana', hint: '', controller: _sessionsPerWeekController, keyboardType: TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createProduct,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
