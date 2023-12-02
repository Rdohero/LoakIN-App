import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/Connectivity/connectivity_service.dart';
import 'package:pas_android/api/api_auth.dart';
import 'package:pas_android/api/carousel_controller.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/navigator_provider.dart';
import 'package:pas_android/api/payment_controller.dart';
import 'package:pas_android/api/poster_api.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/firebase_options.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((__) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (_) => ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.Offline,
        ),
        ChangeNotifierProvider(create: (_) => ApiLoginRegister(),),
        ChangeNotifierProvider(create: (_) => CarouselIndex(),),
        ChangeNotifierProvider(create: (_) => ControllerProduct(),),
        ChangeNotifierProvider(create: (_) => ControllerCart(),),
        ChangeNotifierProvider(create: (_) => ControllerListUser(),),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider(),),
        ChangeNotifierProvider(create: (_) => ControllerPoster(),),
        ChangeNotifierProvider(create: (_) => GoogleController(),),
        ChangeNotifierProvider(create: (_) => PaymentController(),),
        ChangeNotifierProvider(create: (_) => InvoiceController(),),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
