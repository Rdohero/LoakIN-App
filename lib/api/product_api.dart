import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/product_model.dart';

class ControllerProduct extends ChangeNotifier {
  List<Product> productData = [];
  List<Product> productDataById = [];
  List<Product> searchProductData = [];
  bool isLoading = true;
  bool isLoadingDetail = true;
  bool isLoadingSearch = true;

  getAllProduct() async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/product'),
    );

    if (response.statusCode == 200) {
      productData = productFromJson(response.body);
      isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load product');
    }
    isLoading = false;
    notifyListeners();
  }

  getByProductId(int id) async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/product/$id'),
    );

    if (response.statusCode == 200) {
      productDataById = productFromJson(response.body);
      isLoadingDetail = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load product');
    }
    isLoading = false;
    notifyListeners();
  }

  searchProduct(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}/product/search?q=$query'),
      );

      if (response.statusCode == 200) {
        searchProductData = productFromJson(response.body);
        isLoadingSearch = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load product');
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }
}