import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pas_android/api/api_utama.dart';

class ApiLoginRegister extends GetxController{
  var id = 0;
  var tok1 = "";
  var eror2 = "";
  var tok = "";
  var eror = "";
  final TextEditingController emailusernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

    return response;
  }
}