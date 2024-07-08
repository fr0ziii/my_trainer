import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../services/product_service.dart';
import '../../utils/constants.dart';
import '../../view_models/auth_view_model.dart';
import 'add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _products = [];
  final ProductService _productService = ProductService();
  late Future<void> _initialLoad;

  @override
  void initState() {
    super.initState();
    _initialLoad = _fetchProducts(); // Cargar productos al iniciar la pantalla
  }

  Future<void> _fetchProducts() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final user = await authViewModel.getCurrentUser();
    if (user != null) {
      _loadProducts(user.uid);
    }
  }

  Future<void> _loadProducts(String trainerId) async {
    _productService.getProducts(trainerId).listen((products) {
      setState(() {
        _products = products;
      });
    });
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateProductScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        shadowColor: Colors.black,
        title: Text('Servicios', style: appTitleStyle),
      ),
      body: FutureBuilder<void>(
          future: _initialLoad,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                ProductModel product = _products[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    title: Text(product.name, style: appTitleStyle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Precio: ${product.price} ${product.currency}', style: subtitleStyle),
                        Text('Sesiones por semana: ${product.sessionsPerWeek}', style: subtitleStyle),
                      ],
                    ),
                    onTap: () {
                      // Aquí podrías implementar la navegación a una pantalla
                      // detallada del producto si lo deseas
                    },
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[200],
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
