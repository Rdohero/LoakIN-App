import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerCart extends ChangeNotifier {
  List<Cart> cartData = [];
  bool isLoading = true;

  getCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("Token");
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/userAuth/user/cart'),
      body: {
        'Token' : token,
      },
    );

    if (response.statusCode == 200) {
      cartData = cartFromJson(response.body);
      isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<http.Response> addNewCart(int UserID,int ProductID,int Quantity) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/cart'),
      body: {
        'Userid': UserID.toString(),
        'Productid': ProductID.toString(),
        'Quantity': Quantity.toString(),
      },
    );

    if (response.statusCode == 200) {
      cartData = cartFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to create cart');
    }

    return response;
  }
}