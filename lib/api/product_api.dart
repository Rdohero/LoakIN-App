import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/product_model.dart';

class ControllerProduct extends ChangeNotifier {
  int quantity = 1;
  int index = 0;
  List<Product> productData = [];
  bool isLoading = true;

  getAllProduct() async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/product'),
    );

    if (response.statusCode == 200) {
      productData = userFromJson(response.body);
      isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load product');
    }
  }
}