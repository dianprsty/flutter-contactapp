import 'dart:convert';

class Product {
  String id;
  String name;
  int price;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "price": price,
        "description": description,
        "createdAt": createdAt.toString(),
        "updatedAt": updatedAt.toString(),
        "image_url": imageUrl,
      };
}
