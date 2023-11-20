import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pas_android/api/api_auth.dart';
import 'package:pas_android/api/carousel_controller.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/navigator_provider.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(create: (_) => ApiLoginRegister(),),
        ChangeNotifierProvider(create: (_) => CarouselIndex(),),
        ChangeNotifierProvider(create: (_) => ControllerProduct(),),
        ChangeNotifierProvider(create: (_) => ControllerCart(),),
        ChangeNotifierProvider(create: (_) => ControllerListUser(),),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider(),),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
