import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/firebaseHelper.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/homePage.dart';
import 'package:test_app/screens/login.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null){
    UserModel? fetchUserModel = await FirebaseHelper.getuserModelById(currentUser.uid);
    if(fetchUserModel != null){
      runApp(MyAppLoggedIn(userModel: fetchUserModel, firebaseUser: currentUser));
    }
    else {
      runApp(MyApp());
    }
  }
  else{
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser,),
    );
  }
}