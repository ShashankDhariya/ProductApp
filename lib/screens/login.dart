import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/homePage.dart';
import 'package:test_app/screens/signUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void check() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == "" || password == "") {
      print("Enter Details");
    }
    else{
      login(email, password);
    }
  }

  void login(String email, String password) async{
    UserCredential? credential;
    try {
        credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    if(credential != null){
      String uid = credential.user!.uid;

      DocumentSnapshot userData = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      UserModel userModel = UserModel.fromMap(userData.data() as Map<String, dynamic>);

      Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context){
          return HomePage(userModel: userModel, firebaseUser: credential!.user!);
        }
      ),
    );
    }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password provided for that user.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              SizedBox(height: 20),
              Text(
                'College Buddy!',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  fontSize: 28,
                  color: Colors.grey[800],
                ),
              ),
            ),
                
              SizedBox(height: 5),
              Text(
                'Please login to your account',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,
                      size: 16,
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.nunito (
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
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock,
                      size: 16,
                    ),
                    hintText: 'Password',
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
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: 200,
                height: 50.0,
                child: CupertinoButton(
                  color: Colors.blueAccent,
                  onPressed:() {
                    check();
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Text("Sign In",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 15,
                      )
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot your password?',
                  style: GoogleFonts.nunito(
                    textStyle:TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Don\'t have an account?',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context){
                          return SignUpPage();
                      })
                    );
                  },
                  child: Text('Sign up',
                  style: GoogleFonts.nunito(
                    textStyle:TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}