import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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