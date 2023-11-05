import 'package:get/get.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ControllerListUser extends GetxController {
  RxList<User> userById = <User>[].obs;
  RxBool isLoading = true.obs;

  getUserByID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token1 = await pref.getString("Token");
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/userAuth/getUser'),
      body: {
        'Token' : token1,
      },
    );

    if (response.statusCode == 200) {
      userById.value = userFromJson(response.body);
      isLoading.value = false;
    } else {
      throw Exception('Failed to load siswa');
    }
  }
}