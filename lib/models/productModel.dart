class ProductDetail {
  String? rentID;
  String? clgID;
  String? name;
  String? desc;
  String? price;
  String? img;
  String? number;
  ProductDetail({this.rentID, this.clgID, this.name,this.desc,this.price,this.img,this.number,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rentID': rentID,
      'clgID': clgID,
      'name': name,
      'desc': desc,
      'price': price,
      'img': img,
      'number': number,
    };
  }

  ProductDetail.fromMap(Map<String, dynamic> map){
    rentID = map["rentID"] as String;
    clgID = map["clgID"] as String;
    name = map["name"] as String;
    desc = map["desc"] as String ;
    price = map["price"] as String;
    img = map["img"] as String ;
    number = map['number'] as String;
  }
}
