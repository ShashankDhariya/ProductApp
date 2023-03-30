import 'dart:convert';

class homeDataModel{
  static List<Item> items = [
    Item(
      id: 1, 
      name: "Macbook Pro",
      desc: "Apple MacBook Pro with M1 chip",
      image: "https://rukminim1.flixcart.com/image/832/832/khdqnbk0/computer/f/y/t/apple-original-imafxfyqydgvrkzv.jpeg?q=70",
    )];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final String image;

  Item({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
  });

  Item copyWith({
    int? id,
    String? name,
    String? desc,
    num? price,
    num? rooms,
    String? image,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'image': image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc,image: $image)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.desc == desc &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      image.hashCode;
  }
}
