import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/productModel.dart';
import 'package:test_app/models/userModel.dart';
import 'package:uuid/uuid.dart';

class RentPage extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  RentPage({super.key, required this.userModel, required this.firebaseUser});

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  Future<void> check() async {
    String name = nameController.text.trim();
    String desc = descController.text.trim();
    String price = priceController.text.trim();
    String img = imgController.text.trim();
    String number = numberController.text.trim();

    if(name != "" && desc != "" && price != "" && img != ""){
      ProductDetail newProduct = ProductDetail(
        rentID: '1',
        clgID: Uuid().v1(),
        name: name,
        desc: desc,
        price: price,
        img: img,
        number: number,
      );

      await FirebaseFirestore.instance.collection("rent").doc(newProduct.rentID).collection(userModel.college.toString()).doc(newProduct.clgID).set(newProduct.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.near_me,
                    size: 16,
                  ),
                  hintText: 'Product Name',
                  hintStyle: GoogleFonts.nunito (
                    textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                controller: descController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description,
                    size: 16,
                  ),
                  hintText: 'Description',
                  hintStyle: GoogleFonts.nunito (
                    textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on,
                    size: 16,
                  ),
                  hintText: 'Price',
                  hintStyle: GoogleFonts.nunito (
                    textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: imgController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.link,
                    size: 16,
                  ),
                  hintText: 'Image url',
                  hintStyle: GoogleFonts.nunito (
                    textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: numberController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.link,
                    size: 16,
                  ),
                  hintText: 'Active phone number',
                  hintStyle: GoogleFonts.nunito (
                    textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50.0,
                child: Container(
                    decoration: BoxDecoration(
                    boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 25,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 200,
                height: 50.0,
                child: CupertinoButton(
                  color: Colors.blueAccent,
                  onPressed:() {
                    check();
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}