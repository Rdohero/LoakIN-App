import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:pas_android/Component/text_field_widget.dart';
import 'package:pas_android/api/api_auth.dart';
import 'package:pas_android/Forgot%20Password%20All%20Screen/otp_new_forgot_password.dart';
import 'package:provider/provider.dart';

class ForgotNewPassword extends StatelessWidget {
  const ForgotNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FlutterPwValidatorState> validatorKey = GlobalKey<FlutterPwValidatorState>();
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
                                'Buat Password Baru',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          myTextField(
                            controller.passwordForgotController,
                            'Password',
                            true,
                            TextInputType.visiblePassword,
                            Icons.lock,
                                (text) {
                              controller.updateText(text, controller.passwordForgotController);
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          FlutterPwValidator(
                            key: validatorKey,
                            controller: controller.passwordForgotController,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            lowercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            width: 300,
                            height: 100,
                            onSuccess: () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: ElevatedButton(
                              onPressed: controller.isButtonEnabledPasswordOtp(context) ? ()  {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const NewPassword()),
                                );
                              } : null,
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: const Color(0xFFA8A8A8),
                                foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                                minimumSize: Size(screenWidth * 0.7, 43),
                              ),
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: controller.isButtonEnabledPasswordOtp(context) ? Colors.white : Colors.white,
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
    );
  }
}