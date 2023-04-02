import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/userModel.dart';

class ProfilePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const ProfilePage({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  Text(
                    widget.userModel.name.toString(),
                    style: GoogleFonts.pacifico (
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.userModel.email.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[200],
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Source Sans Pro"),
                  ),
                      
                  SizedBox(height: 30,),
                  Text(
                    widget.userModel.college.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Source Sans Pro"),
                  ),
                ],
              ),
            ),
          ),
        )
      );
  }
}