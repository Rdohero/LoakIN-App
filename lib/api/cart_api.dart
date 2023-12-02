import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/cart_model.dart';

class ControllerCart extends ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  set isCheckedChange(bool value) {
    _isChecked = value;
    notifyListeners();
  }
  List<Cart> cartData = [];
  List<Cart> selectedCarts = [];
  bool isLoading = true;
  int counter2 = 1;

  void disableAllSelection() {
    for (var cart in cartData) {
      cart.isSelected = false;
    }

    updateSelectedCarts();
    notifyListeners();
  }

  int calculateTotalPrice() {
    return selectedCarts.fold(0, (total, cart) => total + (cart.quantity * cart.product.price)).toInt();
  }

  double calculatePrice(int quantity,int price ) {
    return (quantity * price).toDouble();
  }

  void toggleAllSelection() {
    bool allSelected = cartData.isNotEmpty && cartData.every((cart) => cart.isSelected);

    for (var cart in cartData) {
      cart.isSelected = !allSelected;
    }

    updateSelectedCarts();
    notifyListeners();
  }

  void updateSelectedCarts() {
    selectedCarts = cartData.where((cart) => cart.isSelected).toList();
  }

  int get counter => counter2;

  void increment() {
    counter2++;
    notifyListeners();
  }

  void decrement() {
    if (counter2 > 0) {
      counter2--;
      notifyListeners();
    }
  }

  void toggleSelection(Cart cart) {
    cart.isSelected = !cart.isSelected;
    updateSelectedCarts();
    notifyListeners();
  }

  getCart(int userID) async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/user/cart/$userID'),
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

  Future<http.Response> deleteCart(int userID,int productID) async {
    final response = await http.delete(
      Uri.parse('${Api.baseUrl}/cart/$userID/$productID'),
    );

    if (response.statusCode == 200) {
      cartData = cartFromJson(response.body);
      disableAllSelection();
      notifyListeners();
    } else {
      throw Exception('Failed to create cart');
    }

    return response;
  }
}