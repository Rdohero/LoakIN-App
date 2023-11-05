import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String fullname;
  String username;
  String foto;
  String email;

  User({
    required this.fullname,
    required this.username,
    required this.foto,
    required this.email,
  });

  factory User.fromJson( Map<String, dynamic> json) => User(
    fullname: json["Fullname"],
    username: json["Username"],
    foto: json["foto"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'username': username,
      'foto': foto,
      'email': email,
    };
  }
}
