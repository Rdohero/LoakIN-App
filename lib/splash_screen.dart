import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/payment_controller.dart';
import 'package:pas_android/api/poster_api.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/bottom_navigator.dart';
import 'package:pas_android/database/database_instance.dart';
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
          var connectivityController = Provider.of<ConnectivityStatus>(context, listen: true);
          var pref = snapshot.data as SharedPreferences;
          var controllerUser = Provider.of<ControllerListUser>(context, listen: false);
          var controllerInvoice = Provider.of<InvoiceController>(context, listen: false);
          var controllerPoster = Provider.of<ControllerPoster>(context, listen: false);
          var controllerGoogle = Provider.of<GoogleController>(context, listen: false);
          var controllerProduct = Provider.of<ControllerProduct>(context, listen: false);
          var controllerPayment = Provider.of<PaymentController>(context, listen: false);
          var controllerCart = Provider.of<ControllerCart>(context, listen: false);
          var controllerFavorite= Provider.of<DatabaseInstance>(context, listen: true);
          controllerFavorite.database();

          String? val = pref.getString("Token");
          String? valGoogle = pref.getString("user_id");

          Future<void> navigateAfterSplash() async {
            controllerFavorite.all();
            if (connectivityController == ConnectivityStatus.Wifi || connectivityController == ConnectivityStatus.Celluler) {
              if (val != null) {
                await controllerUser.getUserByID(context, controllerCart, controllerInvoice);
                await controllerProduct.getAllProduct();
                await controllerPayment.getPayment();
                await controllerPoster.getPoster();
                await controllerInvoice.filterInvoicesByStatus(1);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => BottomNavigator()),
                      (Route<dynamic> route) => false,
                );
              } else if (valGoogle != null) {
                await controllerGoogle.restoreSignInStatus(context, controllerCart, controllerInvoice);
                await controllerProduct.getAllProduct();
                await controllerPayment.getPayment();
                await controllerPoster.getPoster();
                await controllerInvoice.filterInvoicesByStatus(1);
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
            } else {
              controllerFavorite.all();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BottomNavigator()),
                    (Route<dynamic> route) => false,
              );
            }
          }

          Future.delayed(const Duration(seconds: 2), navigateAfterSplash);

          return Container(
            color: const Color(0xFF057ACE),
            child: Center(
              child: AnimationLimiter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                      childAnimationBuilder: (widget) => FadeInAnimation(
                        duration: const Duration(milliseconds: 1000),
                        child: widget,
                      ),
                      children: [
                        const Text(
                          "Loak",
                          style: TextStyle(
                            fontFamily: "SFProDisplay",
                            fontWeight: FontWeight.normal,
                            fontSize: 60,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "IN",
                          style: TextStyle(
                            fontFamily: "SFProDisplay",
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                            color: Color(0xFF0D5D97),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}