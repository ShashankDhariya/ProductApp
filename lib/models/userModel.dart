class UserModel {
  String? uid;
  String? email;
  String? name;
  String? college;
  UserModel({this.uid,this.email,this.name,this.college});

  UserModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    email = map["email"];
    name = map["name"];
    college = map["college"];
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "college": college,
    };
  }
}