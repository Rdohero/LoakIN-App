import 'package:flutter/material.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/bottom_navigator.dart';
import 'package:pas_android/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var pref = snapshot.data as SharedPreferences;
          var controllerUser = Provider.of<ControllerListUser>(context, listen: false);
          var controllerCart = Provider.of<ControllerCart>(context, listen: false);
          var controllerProduct = Provider.of<ControllerProduct>(context, listen: false);

          String? val = pref.getString("Token");

          if (val != null) {
            controllerCart.getCart();
            controllerProduct.getAllProduct();
            controllerUser.getUserByID();
          }

          Future.delayed(const Duration(seconds: 3), () {
            if (val != null) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BottomNavigator()),
                    (Route<dynamic> route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                    (Route<dynamic> route) => false,
              );
            }
          });
          return Container(
            color: const Color(0xFF057ACE),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Loak",
                    style: TextStyle(
                      fontFamily: "SFProDisplay",
                      fontWeight: FontWeight.normal,
                      fontSize: 60,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "IN",
                    style: TextStyle(
                      fontFamily: "SFProDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Color(0xFF0D5D97),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}