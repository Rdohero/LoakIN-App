import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pas_android/Component/otp_field_widget.dart';
import 'package:pas_android/api/api_auth.dart';
import 'package:pas_android/login.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  bool isButtonEnabled(BuildContext context) {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    return controllerLoginRegister.otpController.text.isNotEmpty;
  }

  Future<void> otp(BuildContext context) async {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    final response = await controllerLoginRegister.otp();

    if (response.statusCode == 200) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Login(),
        ),
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
        body: Consumer<ApiLoginRegister>(
          builder: (context, controllerLoginRegister, child) {
            return Container(
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
                            controller: controllerLoginRegister.otpController,
                          ),
                        ),
                        controllerLoginRegister.error3.isEmpty ? Container() : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(controllerLoginRegister.error3,
                            style: const TextStyle(color: Colors.red,fontSize: 12),
                          ),
                        ),
                        OtpTimerButton(
                          height: 50,
                          onPressed: () {
                            controllerLoginRegister.resendOtp();
                          },
                          text: const Text(
                            'Resend OTP',
                            style: TextStyle(fontSize: 15),
                          ),
                          buttonType: ButtonType.text_button,
                          backgroundColor: Colors.blue,
                          duration: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                            onPressed: isButtonEnabled(context) ? () => {
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
                                color: isButtonEnabled(context) ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
