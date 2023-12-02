import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/model/cart_model.dart';
import 'package:pas_android/api/model/invoice_model.dart';
import 'package:pas_android/api/payment_controller.dart';
import 'package:provider/provider.dart';

class InvoiceController extends ChangeNotifier {
  List<Invoice> invoiceData = [];
  List<Invoice> invoiceStatus = [];
  bool isSelect = false;

  filterInvoicesByStatus(int status) {
    invoiceStatus = invoiceData.where((invoice) => invoice.statusId == status).toList();
    notifyListeners();
  }

  getInvoice(int userId) async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/invoice/$userId'),
    );

    if (response.statusCode == 200) {
      invoiceData = invoiceFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load invoice');
    }
    notifyListeners();
  }

  Future<void> checkoutMultipleProducts(int userID, context, int totalAmount, String userAddress, PaymentController paymentController) async {
      var cartController = Provider.of<ControllerCart>(context, listen: false);

      final invoiceResponse = await addNewInvoice(userID, totalAmount, userAddress);

      if (invoiceResponse.statusCode == 200) {
        final invoiceID = invoiceData[0].id;
        paymentController.selectInvoice = invoiceID;
        for (Cart cart in cartController.selectedCarts) {
          final productID = cart.product.id;
          final quantity = cart.quantity;
          final unitPrice = cart.product.price;
          final totalPrice = quantity * unitPrice;

          await addNewInvoiceItem(
              invoiceID, productID, quantity, totalPrice);

          await cartController.deleteCart(userID, productID);
        }
      } else {
        print('Error during checkout');
      }
  }

  Future<http.Response> addNewInvoice(int userID, int totalAmount, String address) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/create/invoice'),
      body: {
        'UserID': userID.toString(),
        'TotalAmount': totalAmount.toString(),
        'Address': address,
      },
    );
    if (response.statusCode == 200) {
      invoiceData = invoiceFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to create invoice');
    }

    return response;
  }

  Future<http.Response> addNewInvoiceItem(int invoiceID,int productID,int quantity, int totalPrice) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/create/invoiceitem'),
      body: {
        'InvoiceID': invoiceID.toString(),
        'ProductID': productID.toString(),
        'Quantity': quantity.toString(),
        'TotalPrice': totalPrice.toString(),
      },
    );

    if (response.statusCode == 200) {
      invoiceData = invoiceFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to create invoice');
    }

    return response;
  }
}
