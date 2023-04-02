import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/productModel.dart';
import 'package:test_app/models/userModel.dart';

class BuyList extends StatefulWidget {
  final UserModel usermodel;
  final User firebaseUser;
  const BuyList({super.key, required this.usermodel, required this.firebaseUser});

  @override
  State<BuyList> createState() => _BuyListState();
}

class _BuyListState extends State<BuyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.usermodel.college.toString() + ' Cluster'),
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("sell").doc('1').collection(widget.usermodel.college.toString()).snapshots(),
        builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active) {
            if(!snapshot.hasData){
              return const Text("Nothing to Show");
            }
            QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
            log(dataSnapshot.docs.length.toString());
              for(int i=0;i<dataSnapshot.docs.length;i++){
                Map<String, dynamic> productMap = dataSnapshot.docs[i].data() as Map<String, dynamic>;
                ProductDetail product = ProductDetail.fromMap(productMap);
                return ListTile(
                  onTap: () async {
                    // DetailsPage();
                  },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product.img.toString()
                      ),
                    ),
                    title: Text(product.name.toString()),
                    subtitle: Text(product.price.toString()),
                  );
              }
            }
          return Center(child: Text('Nothing to Display'));
        }
      )
    );
  }
}