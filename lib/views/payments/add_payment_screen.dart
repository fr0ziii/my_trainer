import 'package:flutter/material.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  AddPaymentScreenState createState() => AddPaymentScreenState();
}

class AddPaymentScreenState extends State<AddPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Payment'),
        ),
        body: const Center(
          child: Text('Add Payment Screen'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
    );
  }

}
