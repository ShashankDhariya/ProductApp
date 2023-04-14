import 'package:flutter/material.dart';
import 'package:test_app/models/productModel.dart';

class whatsAppPage extends StatelessWidget {
  final ProductDetail product;
  const whatsAppPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int  number = int.parse(product.number.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(number.toString()),
      ),
      body: Column(
      ),
    );
  }
}