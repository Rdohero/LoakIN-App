import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pas_android/api/api_utama.dart';

class ApiLoginRegister extends ChangeNotifier{
  var tok1 = "";
  var eror2 = "";
  var tok = "";
  var eror = "";
  var tok2 = "";
  var error3 = "";
  final TextEditingController emailusernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final TextEditingController emailOtpController = TextEditingController();

  void disposeLoginController() {
    passwordController.text = '';
    emailusernameController.text = '';
    notifyListeners();
  }

  void disposeRegisterController() {
    passwordController.text = '';
    emailController.text = '';
    usernameController.text = '';
    fullnameController.text = '';
    notifyListeners();
  }

  void updateText(String newText, TextEditingController controller) {
    controller.text = newText;
    notifyListeners();
  }

  bool isButtonEnabledLogin(BuildContext context) {
    return emailusernameController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  bool isButtonEnabledEmail(BuildContext context) {
    return emailController.text.isNotEmpty;
  }

  bool isButtonEnabledRegister(BuildContext context) {
    return fullnameController.text.isNotEmpty && usernameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  Future<http.Response> loginUser() async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/login'),
      body: {
        'Emailuser' : emailusernameController.text,
        'Password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      tok1 = jsonResponse["Token"];
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      eror2 = jsonResponse["Error"];
    }
    notifyListeners();
    return response;
  }

  Future<http.Response> otp() async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/emailve'),
      body: {
        'Email' : emailOtpController.text,
        'Otp' : otpController.text,
      },
    );

    if (response.statusCode == 200) {
      otpController.text = "";
      error3 = "";
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      tok2 = jsonResponse["Status"];
    } else {
      otpController.text = "";
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      error3 = jsonResponse["Error"];
    }
    notifyListeners();
    return response;
  }

  resendOtp() async {
    await http.post(
      Uri.parse('${Api.baseUrl}/resendOtp'),
      body: {
        'Email' : emailOtpController.text,
      },
    );
  }

  Future<http.Response> registerUser() async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/signup'),
      body: {
        'Fullname': fullnameController.text,
        'Username': usernameController.text,
        'Email': emailController.text,
        'Password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      emailOtpController.text = emailController.text;
      fullnameController.text = "";
      usernameController.text = "";
      emailController.text = "";
      passwordController.text = "";
      eror = "";
      tok = "";
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      tok = jsonResponse["Status"];
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      eror = jsonResponse["Error"];
    }
    notifyListeners();
    return response;
  }
}