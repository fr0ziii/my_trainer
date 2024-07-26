import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController paymentController;
  late GlobalKey<FormState> paymentForm;
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    paymentController = TextEditingController();
    paymentForm = GlobalKey<FormState>();
  }

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      const gpay = PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            googlePay: gpay,
            merchantDisplayName: 'Adiwele',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        displayPaymentSheet();
      }
    } catch (e, s) {
      debugPrint('exception:$e$s');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']!}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      return jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
            (value) {},
      );
    } on StripeException catch (e) {
      debugPrint('Payment failed: ${e.error.localizedMessage}');
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment Example'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: paymentForm,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: paymentController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter an amount',
                  fillColor: const Color(0xffF5F5F5),
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xff1D275C),
                      width: 2.01,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xffCCCCCC),
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xffD6001A),
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xffF0642F),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (paymentForm.currentState!.validate()) {
                    debugPrint(paymentController.text);
                    var paymentAmount = int.parse(paymentController.text) * 100;

                    makePayment(amount: paymentAmount.toString(), currency: "USD");
                  }
                },
                child: const Text('Make Payment'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
