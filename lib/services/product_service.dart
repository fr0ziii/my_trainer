import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import 'firestore_service.dart';

class ProductService {
  final FirestoreService _firestoreService = FirestoreService();
  final String _collectionPath = 'products';
  final String _stripeApiBase = 'https://api.stripe.com/v1';
  final String _stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY']!;

  Future<void> createProduct(ProductModel product) async {
    await _createStripeProduct(product);
  }

  Future<ProductModel> getProduct(String id) async {
    final DocumentSnapshot doc =
    await _firestoreService.getDocument(_collectionPath, id);
    return ProductModel.fromDocument(doc);
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestoreService.updateDocument(_collectionPath, product.id, product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _firestoreService.deleteDocument(_collectionPath, id);
  }

  Future<void> setProduct(ProductModel product) async {
    await _firestoreService.setDocument(_collectionPath, product.id, product.toMap());
  }

  Stream<List<ProductModel>> getProducts(String trainerId) {
    return FirebaseFirestore.instance
        .collection(_collectionPath)
        .where('trainerId', isEqualTo: trainerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromDocument(doc)).toList();
    });
  }

  Future<void> _createStripeProduct(ProductModel product) async {
    final productData = {
      'name': product.name,
      'description': product.description,
    };

    final response = await http.post(
      Uri.parse('$_stripeApiBase/products'),
      headers: {
        'Authorization': 'Bearer $_stripeSecretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: productData,
    );

    if (response.statusCode == 200) {
      dynamic responseBody = json.decode(response.body);
      dynamic productId = responseBody['id'];
      dynamic priceId = await _createStripePrice(productId, product.price);
      product.stripeId = productId;
      product.priceId = priceId;
      await _firestoreService.addDocument(_collectionPath, product.toMap());
    } else {
      throw Exception('Error al crear el producto en Stripe: ${response.body}');
    }
  }

  Future<dynamic> _createStripePrice(String productId, double price) async {
    final priceData = {
      'unit_amount': (price * 100).toInt().toString(),
      'currency': 'eur',
      'recurring[interval]': 'month',
      'product': productId,
    };

    final response = await http.post(
      Uri.parse('$_stripeApiBase/prices'),
      headers: {
        'Authorization': 'Bearer $_stripeSecretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: priceData,
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear el precio en Stripe: ${response.body}');
    }

    return json.decode(response.body)['id'];
  }
}
