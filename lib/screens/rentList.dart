import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/productModel.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/details.dart';

class RentList extends StatefulWidget {
  final UserModel usermodel;
  final User firebaseUser;
  const RentList({super.key, required this.usermodel, required this.firebaseUser});

  @override
  State<RentList> createState() => _RentListState();
}

class _RentListState extends State<RentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('${widget.usermodel.college} Cluster'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("rent").doc("1").collection(widget.usermodel.college.toString()).snapshots(),
            builder:(context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ), 
                    itemCount: dataSnapshot.docs.length,
                    itemBuilder:(context, index) {
                      ProductDetail currentProduct = ProductDetail.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:(context) {
                                return Details(usermodel: widget.usermodel, firebaseUser: widget.firebaseUser, product: currentProduct);
                              },
                            )
                          );
                        },
                        child: Card(
                          elevation: 0.2,
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                width: 160,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                    image: NetworkImage(currentProduct.img.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(currentProduct.name.toString(),
                                style: GoogleFonts.montserrat (
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                              Text("Rs.${currentProduct.price}",
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                        ),
                      );
                    },
                  );
                }
                else if(snapshot.hasError) {
                  return const Center(
                    child: Text("An error occured! Please check your internet connection"),
                  );
                }
                else {
                  return const Center(
                    child: Text("Say hi!"),
                  );
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      )
    );
  }
}