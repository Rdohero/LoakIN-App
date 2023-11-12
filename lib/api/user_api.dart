import 'package:flutter/cupertino.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ControllerListUser extends ChangeNotifier {
  List<User> userById = [];
  bool isLoading = true;

  getUserByID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("Token");
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/userAuth/getUser'),
      body: {
        'Token' : token,
      },
    );

    if (response.statusCode == 200) {
      userById = userFromJson(response.body);
      isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load siswa');
    }
  }
}