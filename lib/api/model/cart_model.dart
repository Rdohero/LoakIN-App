import 'dart:convert';

List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  int id;
  int userId;
  int productId;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
  ProductCart product;
  bool isSelected;

  Cart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.isSelected,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: ProductCart.fromJson(json["Product"]),
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "quantity": quantity,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "Product": product.toJson(),
    "isSelected": isSelected,
  };
}

class ProductCart {
  int id;
  int userId;
  String image;
  String name;
  int price;
  String location;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  ProductCart({
    required this.id,
    required this.userId,
    required this.image,
    required this.name,
    required this.price,
    required this.location,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
    id: json["id"],
    userId: json["user_id"],
    image: json["image"],
    name: json["name"],
    price: json["price"],
    location: json["location"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "image": image,
    "name": name,
    "price": price,
    "location": location,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "User": user.toJson(),
  };
}

class User {
  int id;
  String foto;
  String fullname;
  String username;
  int saldo;
  String email;
  String password;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.foto,
    required this.fullname,
    required this.username,
    required this.saldo,
    required this.email,
    required this.password,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    foto: json["foto"],
    fullname: json["fullname"],
    username: json["username"],
    saldo: json["saldo"],
    email: json["email"],
    password: json["password"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foto": foto,
    "fullname": fullname,
    "username": username,
    "saldo": saldo,
    "email": email,
    "password": password,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}