import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String trainerId;
  String stripeId;
  String priceId;
  final String name;
  final String description;
  final double price;
  final String currency;
  final int sessionsPerWeek;
  final DateTime creationDate;

  ProductModel({
    required this.id,
    required this.trainerId,
    required this.stripeId,
    required this.priceId,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.sessionsPerWeek,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trainerId': trainerId,
      'stripeId': stripeId,
      'priceId': priceId,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'sessionsPerWeek': sessionsPerWeek,
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: data['id'],
      trainerId: data['trainerId'],
      stripeId: data['stripeId'],
      priceId: data['priceId'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      currency: data['currency'],
      sessionsPerWeek: data['sessionsPerWeek'],
      creationDate: DateTime.parse(data['creationDate']),
    );
  }
}
