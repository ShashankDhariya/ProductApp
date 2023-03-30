import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/screens/home.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});
  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

String dropdownValue = "one";
class _CompleteProfilePageState extends State<CompleteProfilePage> {
  TextEditingController nameController = TextEditingController();

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
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder:(context) {
                               return HomePage();
                              },
                            )
                        );
                        log(dropdownValue);
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