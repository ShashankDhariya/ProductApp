import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/completeProfile.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void check(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = confirmPasswordController.text.trim();
    
    if(email == "" || password == "" || cpassword == ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your details")));
    }
    else if(password != cpassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password don't match.")));
    }
    else {
      signup(email, password);
    }
  }

  void signup(String email, String password) async{
    UserCredential? credential;
    try {
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is too weak."))); 

    } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account already exists.")));
    }
    } catch (e) {
    print(e);
  }

  if(credential != null){
    String uid = credential.user!.uid;
    UserModel newUser = UserModel(
      uid: uid,
      email: email,
      name: "",
      college: "",
    );
    await FirebaseFirestore.instance.collection("Users").doc(uid).set(newUser.toMap()).then((value) {
      print("New User");
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder:(context) {
            return CompleteProfilePage(firebaseUser: credential!.user!, userModel: newUser);
          },
        ));
    });
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
                  image: AssetImage("assets/images/bg1.png"),
                  fit: BoxFit.cover,
                ),
              ),

              child: Column(
                children: [
                  SizedBox(height: 150),
                  Text(
                    'College Buddy!',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                      fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              
              SizedBox(height: 5),
              Text(
                'Enter Your Details',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[600],
                ),
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
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open,
                      size: 16,
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.nunito (
                      textStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.indigo[800],
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
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock,
                      size: 16,
                    ),
                    hintText: 'Confirm Password',
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
                      child: Text("Sign Up"),
                    ),
                  ),
                 SizedBox(height: 10),

                TextButton(onPressed:() {
                  Navigator.pop(context);              
                },
                child: Text('Back To Login'),
              ),
              SizedBox(height: 180,)
            ],
          ),
        ),
      ),
    );
   }
}