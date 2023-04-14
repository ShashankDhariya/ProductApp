import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/models/userModel.dart';

class FirebaseHelper{
  static Future<UserModel?> getuserModelById(String uid) async {
    UserModel? userModel;

    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    if(docSnap.data() != null){
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel;
  }
}