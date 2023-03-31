import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/home.dart';
import 'package:velocity_x/velocity_x.dart';

class CompleteProfilePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const CompleteProfilePage({super.key, required this.userModel, required this.firebaseUser});
  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

String dropdownValue = "one";
class _CompleteProfilePageState extends State<CompleteProfilePage> {
  TextEditingController nameController = TextEditingController();
  String dropdownValue = "Enter your College";
  String _selectedItem = "";

  List<String> _items = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  void check(){
    String name = nameController.text.trim();

    if(name == "" || dropdownValue == "Enter your College"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Please enter data".text.make()));
    }
    else{
      widget.userModel.name = name;
      widget.userModel.college = dropdownValue;
      FirebaseFirestore.instance.collection("Users").doc(widget.userModel.uid).set(widget.userModel.toMap()).then((value) {
        print("Data Uploaded");
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder:(context) {
              return HomePage();
            },
            )
          );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 60,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,
                      size: 16,
                    ),
                    hintText: 'Enter your name',
                    hintStyle: GoogleFonts.openSans (
                      textStyle: TextStyle(
                        fontSize: 14,
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

              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.all(4),
                  child: Column(
                    children: [                
                      DropdownButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.grey,
                        underline: SizedBox(), // Remove the default underline
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        dropdownColor: Colors.white,
                        value: dropdownValue,
                        items: <String>['Graphic Era University', 'University Of Engineering And Management', 'IIT Roorkee', 'Enter your College']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),
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
                      },
                      borderRadius: BorderRadius.circular(25),
                      child: Text("Submit"),
                    ),
                  ),
                ),
            ],
          )
        ),
      ),
    );
  }
}