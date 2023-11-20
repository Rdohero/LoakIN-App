import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/poster_model.dart';

class ControllerPoster extends ChangeNotifier {
  List<Poster> posterData = [];

  getPoster() async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/poster'),
    );

    if (response.statusCode == 200) {
      posterData = posterFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load product');
    }
    notifyListeners();
  }
}