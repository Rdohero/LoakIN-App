import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String image;
  String name;
  int price;
  String location;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic carts;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.location,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.carts,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    price: json["price"],
    location: json["location"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    carts: json["Carts"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "price": price,
    "location": location,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "Carts": carts,
  };
}