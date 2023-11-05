import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_android/Widget/google_facebook.dart';
import 'package:pas_android/Widget/text_field_widget.dart';
import 'package:pas_android/api/api_login_register.dart';
import 'package:pas_android/login.dart';
import 'package:pas_android/register2.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final ApiLoginRegister controller = Get.put(ApiLoginRegister());

  bool isButtonEnabled() {
    return controller.emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
              image: AssetImage("assets/images/baground_login_daftar.png"),
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
                            'Daftar Akun',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      myTextField(
                          controller.emailController,
                          'Email',
                          false,
                          TextInputType.emailAddress,
                          Icons.email_rounded
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
                        onPressed: isButtonEnabled() ? () => {
                          Get.to(() => const Register2())
                        } : null,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: const Color(0xFFA8A8A8),
                          foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                          minimumSize: Size(screenWidth * 0.7, 43),
                        ),
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 15,
                            color: isButtonEnabled() ? Colors.white : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.82,
                        height: screenHeight * 0.06,
                        child: const Center(
                          child: Text(
                            'Daftar dengan',
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
                            const Text("Sudah punya akun?", style: TextStyle(fontSize: 11),),
                            TextButton(
                              onPressed: () {
                                Get.off(() => const Login());
                              },
                              child: const Text(
                                "Masuk Sekarang !",
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
