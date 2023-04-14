import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        title: Text(widget.usermodel.college.toString() + ' Cluster'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("rent").doc("1").collection(widget.usermodel.college.toString()).snapshots(),
            builder:(context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 8,
                          child: Container(
                            child: Column(
                              children: [
                                Text(currentProduct.name.toString()),
                                SizedBox(height: 10,),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(currentProduct.img.toString()),
                                ),
                                SizedBox(height: 10,),
                                Title( color: Colors.black,
                                child: Text("Rs."+currentProduct.price.toString())),
                              ],
                            ),
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