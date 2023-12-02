import 'dart:convert';

List<Invoice> invoiceFromJson(String str) => List<Invoice>.from(json.decode(str).map((x) => Invoice.fromJson(x)));

String invoiceToJson(List<Invoice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
  int id;
  int userId;
  int totalAmount;
  int statusId;
  int paymentId;
  String address;
  DateTime createdAt;
  DateTime updatedAt;
  List<InvoiceItem> invoiceItems;
  Status status;
  PaymentItem paymentItem;

  Invoice({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.statusId,
    required this.paymentId,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.invoiceItems,
    required this.status,
    required this.paymentItem,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    id: json["id"],
    userId: json["user_id"],
    totalAmount: json["total_amount"],
    statusId: json["status_id"],
    paymentId: json["payment_id"],
    address: json["address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    invoiceItems: List<InvoiceItem>.from(json["InvoiceItems"].map((x) => InvoiceItem.fromJson(x))),
    status: Status.fromJson(json["Status"]),
    paymentItem: PaymentItem.fromJson(json["PaymentItem"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total_amount": totalAmount,
    "status_id": statusId,
    "payment_id": paymentId,
    "address": address,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "InvoiceItems": List<dynamic>.from(invoiceItems.map((x) => x.toJson())),
    "Status": status.toJson(),
    "PaymentItem": paymentItem.toJson(),
  };
}

class InvoiceItem {
  int id;
  int invoiceId;
  int productId;
  int quantity;
  int totalPrice;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  InvoiceItem({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
    id: json["id"],
    invoiceId: json["invoice_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    totalPrice: json["total_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromJson(json["Product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_id": invoiceId,
    "product_id": productId,
    "quantity": quantity,
    "total_price": totalPrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "Product": product.toJson(),
  };
}

class PaymentItem {
  int id;
  String payment;
  String deskripsi;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentItem({
    required this.id,
    required this.payment,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) => PaymentItem(
    id: json["id"],
    payment: json["payment"],
    deskripsi: json["deskripsi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment": payment,
    "deskripsi": deskripsi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Product {
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

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

class Status {
  int id;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Status({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}