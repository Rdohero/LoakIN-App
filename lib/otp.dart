import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_android/Widget/otp_field_widget.dart';
import 'package:pas_android/api/api_login_register.dart';
import 'package:pas_android/login.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final ApiLoginRegister controller = Get.put(ApiLoginRegister());

  bool isButtonEnabled() {
    return controller.otpController.text.isNotEmpty;
  }

  Future<void> otp(BuildContext context) async {
    final response = await controller.otp();

    if (response.statusCode == 200) {
      final status = controller.tok1;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(status)),
      );
      Get.off(() => const Login());
    } else {
      final error = controller.eror2;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
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
                          'Verify Akun',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15),
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: const Color(0xFFEDF1FF)),
                          ),
                        ),
                        controller: controller.otpController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled() ? () => {
                          otp(context)
                        } : null,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: const Color(0xFFA8A8A8),
                          foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                          minimumSize: Size(screenWidth * 0.7, 43),
                        ),
                        child: Text(
                          'Verify',
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
