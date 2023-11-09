import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ControllerListUser controller = Get.put(ControllerListUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Profilee(controller),
    );
  }
}

Widget Profilee(controller) {
  late var user = controller.userById[0];
  return Obx(() {
    return controller.isLoading.value
        ? const CircularProgressIndicator()
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  shadowColor: Color.fromARGB(63, 43, 43, 43),
                  title: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          );
  });
}
