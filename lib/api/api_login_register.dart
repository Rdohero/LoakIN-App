import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pas_android/api/api_utama.dart';

class ApiLoginRegister extends ChangeNotifier{
  var tok1 = "";
  var eror2 = "";
  var tok = "";
  var eror = "";
  final TextEditingController emailusernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

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
        'Otp' : otpController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      tok1 = jsonResponse["Status"];
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      eror2 = jsonResponse["Error"];
    }
    notifyListeners();
    return response;
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