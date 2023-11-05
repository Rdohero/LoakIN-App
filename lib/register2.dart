import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_android/Widget/text_field_widget.dart';
import 'package:pas_android/api/api_login_register.dart';
import 'package:pas_android/login.dart';

class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final ApiLoginRegister controller = Get.put(ApiLoginRegister());

  bool isButtonEnabled() {
    return controller.fullnameController.text.isNotEmpty && controller.usernameController.text.isNotEmpty && controller.emailController.text.isNotEmpty && controller.passwordController.text.isNotEmpty;
  }

  Future<void> register(BuildContext context) async {

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
                        controller.fullnameController,
                        'Name',
                        false,
                        TextInputType.text,
                        Icons.person
                    ),
                    myTextField(
                        controller.usernameController,
                        'Username',
                        false,
                        TextInputType.text,
                        Icons.person
                    ),
                    myTextField(
                        controller.passwordController,
                        'Password',
                        true,
                        TextInputType.visiblePassword,
                        Icons.lock
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled() ? () => {
                          register(context)
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
