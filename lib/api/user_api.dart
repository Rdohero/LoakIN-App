import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ControllerListUser extends ChangeNotifier {
  List<User> userById = [];
  XFile? returnedImage;

  XFile? get returnedImage2 => returnedImage;

  bool isLoading = true;

  pickImage(image) async {
    returnedImage = image;
    notifyListeners();
  }

  Future<http.Response> updatePhotoUserData() async {
    var returnedImage1 = returnedImage;
    String imagePath = returnedImage1!.path;
    String fileExtension = imagePath.split('.').last;
    final imageBytes = await returnedImage1.readAsBytes();

    final multipartFile = http.MultipartFile.fromBytes(
      'foto',
      imageBytes,
      filename: returnedImage1.path,
      contentType: MediaType('image', fileExtension),
    );

    final request = http.MultipartRequest('PUT', Uri.parse('${Api.baseUrl}/user/foto/${userById[0].id.toString()}'));
    request.files.add(multipartFile);

    final response = await request.send();

    final streamedResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      returnedImage = null;
      userById = userFromJson(streamedResponse.body);
    } else {
    }
    return streamedResponse;
  }

  getUserByID(BuildContext context, ControllerCart controllerCart, InvoiceController controllerInvoice) async {
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
      int userId = userById[0].id;
      controllerCart.getCart(userId);
      controllerInvoice.getInvoice(userId);
      notifyListeners();
    } else {
      throw Exception('Failed to load siswa');
    }
  }
}