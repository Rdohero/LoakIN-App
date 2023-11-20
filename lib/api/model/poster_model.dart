import 'dart:convert';

List<Poster> posterFromJson(String str) => List<Poster>.from(json.decode(str).map((x) => Poster.fromJson(x)));

String posterToJson(List<Poster> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Poster {
  int id;
  String poster;
  DateTime createdAt;
  DateTime updatedAt;

  Poster({
    required this.id,
    required this.poster,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
    id: json["id"],
    poster: json["Poster"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Poster": poster,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}