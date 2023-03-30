import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/homeWidget.dart';
import 'package:test_app/widgets/homeGrid.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List? data;
  
  get icon => null;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final homeJson = 
        await rootBundle.loadString("assets/files/homeWidget.json");
    final decodeData = jsonDecode(homeJson);
    var optionData = decodeData["options"];
    homeDataModel.items = List.from(optionData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // bottom:Colors.white,
        

        title: Text("Finance Buddy",
          style: GoogleFonts.openSans (
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
            ),
          ),
        ),
      ),

      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.person),
        ],
      ).p8().color(Colors.greenAccent),
      body: Container(
        child:homeDataModel.items.length > 0
            ? homeView()
            : CircularProgressIndicator(),
      ),
    );
  }
}