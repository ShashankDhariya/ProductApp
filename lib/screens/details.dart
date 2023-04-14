import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/productModel.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/whatsappPage.dart';

class Details extends StatefulWidget {
  final UserModel usermodel;
  final User firebaseUser;
  final ProductDetail product;
  const Details({super.key, required this.usermodel, required this.firebaseUser, required this.product});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name.toString()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.product.desc.toString()),
            Text("Rs " + widget.product.price.toString()),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.product.img.toString()),
            ),
            FloatingActionButton(
              onPressed:() {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) {
                      return whatsAppPage(product: widget.product,);
                    },
                    )
                );
              },
              child: Icon(Icons.chat_rounded),
            ),
          ],
        )
        ),
    );
  }
}