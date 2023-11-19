import 'package:flutter/material.dart';
import 'package:pas_android/Component/google_facebook.dart';
import 'package:pas_android/Component/text_field_widget.dart';
import 'package:pas_android/api/api_auth.dart';
import 'package:pas_android/Forgot%20Password%20All%20Screen/otp_forgot_password.dart';
import 'package:pas_android/register.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Future<void> login(BuildContext context) async {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    final response = await controllerLoginRegister.loginUser();

    if (response.statusCode == 200) {
      final token = controllerLoginRegister.tok1;
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("Token", token);
      controllerLoginRegister.submitLoading = false;
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const SplashScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<ApiLoginRegister>(
        builder: (context, controller, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background_login_daftar.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fill
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.82,
                            height: screenHeight * 0.10,
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Masuk Akun',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          myTextField(
                            controller.emailusernameController,
                            'Email Or Username',
                            false,
                            TextInputType.emailAddress,
                            Icons.email_rounded,
                                (text) {
                              controller.updateText(text, controller.emailusernameController);
                            },
                          ),
                          myTextField(
                            controller.passwordController,
                            'Password',
                            true,
                            TextInputType.text,
                            Icons.lock,
                                (text) {
                              controller.updateText(text, controller.passwordController);
                            },
                          ),
                          controller.eror2.isEmpty ? Container() : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(controller.eror2,
                              style: const TextStyle(color: Colors.red,fontSize: 12),),
                          ),
                          SizedBox(
                            width: screenWidth * 0.82,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  controller.emailusernameController.text = "";
                                  controller.passwordController.text = "";
                                  controller.eror2 = "";
                                  Navigator.pushReplacement<void, void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const OtpForgotPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Lupa Password ?",
                                  style: TextStyle(
                                    color: Color(0xFF77B2DE),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: controller.isButtonEnabledLogin(context) ? () async {
                              controller.submitLoading = true;
                              login(context);
                            } : null,
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: const Color(0xFFA8A8A8),
                              foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                              minimumSize: Size(screenWidth * 0.7, 43),
                            ),
                            child: controller.submitLoading
                            ? SizedBox(
                              width: 123,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: const CircularProgressIndicator(color: Colors.white,strokeWidth: 3),
                                  ),
                                  const SizedBox(width: 15,),
                                  Text(
                                    "Loading...",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: controller.isButtonEnabledRegister(context) ? Colors.white : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 15,
                                color: controller.isButtonEnabledLogin(context) ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.82,
                            height: screenHeight * 0.06,
                            child: const Center(
                              child: Text(
                                'Atau Masuk dengan',
                                style: TextStyle(
                                  color: Color(0xFF9F9F9F),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buttonGoBuk(
                                  null,
                                  screenWidth,
                                  const Text("Google", style: TextStyle(color: Colors.black,fontSize: 11)),
                                  Image.asset("assets/images/icons_images/devicon_google.png",width: 20,height: 20,)
                              ),
                              buttonGoBuk(null,
                                screenWidth,
                                const Text("Facebook", style: TextStyle(color: Colors.black,fontSize: 11)),
                                const Icon(Icons.facebook, color: Colors.blue,),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.82,
                            height: screenHeight * 0.10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Belum punya akun?", style: TextStyle(fontSize: 11),),
                                TextButton(
                                  onPressed: () {
                                    controller.disposeLoginController();
                                    Navigator.pushReplacement<void, void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => const Register(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Daftar Sekarang !",
                                    style: TextStyle(
                                      color: Color(0xFF609BC6),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}