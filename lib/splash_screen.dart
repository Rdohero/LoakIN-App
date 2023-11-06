import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/bottom_navigator.dart';
import 'package:pas_android/home.dart';
import 'package:pas_android/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ControllerListUser controller = Get.put(ControllerListUser());

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future<void> initPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("Token");

    if (val != null) {
      controller.getUserByID();
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (val != null) {
        Get.offAll(() => const BottomNavigator());
      } else {
        Get.offAll(() => const Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_splash.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Loak",style: TextStyle(fontFamily: "SFProDisplay",fontWeight: FontWeight.normal,fontSize: 60,decoration: TextDecoration.none,color: Colors.white)),
          Text("IN",style: TextStyle(fontFamily: "SFProDisplay",fontWeight: FontWeight.bold,fontSize: 60,color: Color(0xFF0D5D97),decoration: TextDecoration.none)),
        ],
      ),
    );
  }
}