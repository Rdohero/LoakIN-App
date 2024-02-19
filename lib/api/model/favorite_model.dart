import 'dart:typed_data';

class FavoriteModel {
  int? id;
  Uint8List? image;
  double? price;
  String? name,location,description;

  FavoriteModel({
   this.id , this.image, this.price, this.name, this.location, this.description
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      image: json['image'],
      price: json['price'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
    );
  }
}