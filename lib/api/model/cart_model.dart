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
  UserCart user;

  Cart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.user,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: ProductCart.fromJson(json["Product"]),
    user: UserCart.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "quantity": quantity,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "Product": product.toJson(),
    "User": user.toJson(),
  };
}

class ProductCart {
  int id;
  String image;
  String name;
  int price;
  String location;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic carts;

  ProductCart({
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

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
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

class UserCart {
  int id;
  String foto;
  String fullname;
  String username;
  String email;
  String password;
  bool isActive;
  dynamic carts;
  DateTime createdAt;
  DateTime updatedAt;

  UserCart({
    required this.id,
    required this.foto,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.isActive,
    required this.carts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserCart.fromJson(Map<String, dynamic> json) => UserCart(
    id: json["id"],
    foto: json["foto"],
    fullname: json["fullname"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    isActive: json["is_active"],
    carts: json["Carts"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foto": foto,
    "fullname": fullname,
    "username": username,
    "email": email,
    "password": password,
    "is_active": isActive,
    "Carts": carts,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}