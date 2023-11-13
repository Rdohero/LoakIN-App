import 'package:flutter/material.dart';
import 'package:pas_android/Component/google_facebook.dart';
import 'package:pas_android/Component/text_field_widget.dart';
import 'package:pas_android/api/api_login_register.dart';
import 'package:pas_android/register.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  bool isButtonEnabled(BuildContext context) {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    return controllerLoginRegister.emailusernameController.text.isNotEmpty && controllerLoginRegister.passwordController.text.isNotEmpty;
  }

  Future<void> login(BuildContext context) async {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    final response = await controllerLoginRegister.loginUser();

    if (response.statusCode == 200) {
      final token = controllerLoginRegister.tok1;
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("Token", token);
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const SplashScreen(),
        ),
      );
    } else {
      final error = controllerLoginRegister.eror2;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.82,
                      height: screenHeight * 0.06,
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
                        controllerLoginRegister.emailusernameController,
                        'Email Or Username',
                        false,
                        TextInputType.emailAddress,
                        Icons.email_rounded
                    ),
                    myTextField(
                        controllerLoginRegister.passwordController,
                        'Password',
                        true,
                        TextInputType.text,
                        Icons.lock
                    ),
                    SizedBox(
                      width: screenWidth * 0.82,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
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
                      onPressed: isButtonEnabled(context) ? () => {
                        login(context)
                      } : null,
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: const Color(0xFFA8A8A8),
                        foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                        minimumSize: Size(screenWidth * 0.7, 43),
                      ),
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 15,
                          color: isButtonEnabled(context) ? Colors.white : Colors.white,
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
                      height: screenHeight * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Belum punya akun?", style: TextStyle(fontSize: 11),),
                          TextButton(
                            onPressed: () {
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
}