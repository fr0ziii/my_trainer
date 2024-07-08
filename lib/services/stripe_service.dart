import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StripeService {
  final String _apiBase = 'https://api.stripe.com/v1';
  final String _secret =  dotenv.env['STRIPE_SECRET_KEY']!;

  Future<Map<String, dynamic>> createCustomer(String email) async {
    final url = '$_apiBase/customers';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $_secret',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create customer: ${response.body}');
    }
  }
}
