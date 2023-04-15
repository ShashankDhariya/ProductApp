import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/productModel.dart';
import 'package:test_app/models/userModel.dart';
import 'package:velocity_x/velocity_x.dart';

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
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Text("Details"),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Rs. ${widget.product.price}",
            style: GoogleFonts.nunito(
              fontSize: 18,
            ),
          ),
          CupertinoButton.filled(
            borderRadius: BorderRadius.circular(30),
            child: Text("Buy"), 
            onPressed:() {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.product.img.toString(),
              
            ),
            Text(
              widget.product.name.toString(),
              style: GoogleFonts.nunito(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Description: ",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ).objectTopLeft(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                widget.product.desc.toString(),
                style: GoogleFonts.nunito(
                  fontSize: 16
                ),
              ).objectTopLeft(),
            ),
          ],  
        ),
      ),  
    );
  }
}