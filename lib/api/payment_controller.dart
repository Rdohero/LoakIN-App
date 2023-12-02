import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/model/invoice_model.dart';
import 'package:pas_android/api/model/payment_model.dart';

class PaymentController extends ChangeNotifier {
  List<Payment> paymentData = [];
  int selectedPaymentIndex = -1;
  int selectedPayment = 0;
  int selectInvoice = 0;

  getPayment() async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/payment'),
    );

    if (response.statusCode == 200) {
      paymentData = paymentFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load payment');
    }
    notifyListeners();
  }

  updatePayment(int invoiceID, int paymentID, InvoiceController controllerInvoice, int userID) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/payment'),
      body: {
        'User' : userID.toString(),
        'Invoice' : invoiceID.toString(),
        'Payment' : paymentID.toString(),
      },
    );

    if (response.statusCode == 200) {
      controllerInvoice.invoiceData = invoiceFromJson(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to update payment');
    }
    notifyListeners();
  }

  selectPayment(int index, int id) {
    selectedPaymentIndex = index;
    selectedPayment = id;
    notifyListeners();
  }
}