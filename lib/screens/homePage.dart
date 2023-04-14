import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/screens/login.dart';
import 'package:test_app/screens/profile.dart';
import 'package:test_app/screens/rent.dart';
import 'package:test_app/screens/rentList.dart';
import 'package:test_app/screens/sell.dart';
import 'buyList.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const HomePage({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 106, 127, 228),
        actions: [
          IconButton(
            onPressed:() async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder:(context) {
                    return LoginPage();
                  },
                )
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 90,),
            Text("Welcome!",
              style: GoogleFonts.pacifico(
                fontSize: 25,
                color: Colors.cyanAccent
              ),
            ),
            const SizedBox(height: 10,),
            Text(widget.userModel.name.toString(),
              style: GoogleFonts.nunito(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 80,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: CupertinoButton(
                color: const Color.fromARGB(255, 106, 127, 228),
                borderRadius: BorderRadius.circular(40.0),
                child: const Text("RENT"), 
                onPressed:() {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) {
                        return RentList(usermodel: widget.userModel, firebaseUser: widget.firebaseUser);
                      },
                    )
                  );
                },
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: CupertinoButton(
                color: const Color.fromARGB(255, 106, 127, 228),
                borderRadius: BorderRadius.circular(40.0),
                child: const Text("BUY"), 
                onPressed:() {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) {
                        return BuyList(usermodel: widget.userModel, firebaseUser: widget.firebaseUser);
                      },
                    )
                  );
                },
              ),
            ),
            const SizedBox(height: 20,),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: CupertinoButton(
                color: const Color.fromARGB(255, 106, 127, 228),
                borderRadius: BorderRadius.circular(40.0),
                child: const Text("SELL"), 
                onPressed:() {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) {
                        return Sell(userModel: widget.userModel,firebaseUser: widget.firebaseUser);
                      },
                    )
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 35, right: 35),
              width: double.infinity,
              child: CupertinoButton(
                color: const Color.fromARGB(255, 106, 127, 228),
                borderRadius: BorderRadius.circular(40.0),
                child: const Text("GIVE ON RENT"), 
                onPressed:() {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) {
                        return RentPage(userModel: widget.userModel, firebaseUser: widget.firebaseUser,);
                      },
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        buttonPadding: const EdgeInsets.only(right: 20, left: 20),
        children: [
          InkWell(
            child: const Icon(Icons.home),
            onTap:() {
            },
          ),

          InkWell(
            child: const Icon(Icons.shopping_bag),
            onTap:() {
            },
          ),

          InkWell(
            child: const Icon(Icons.person),
            onTap:() {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(context) {
                    return ProfilePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser,);
                  },
                )
              );
            },
          )
        ],
      ),
    );
  }
}