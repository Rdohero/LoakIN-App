import 'package:flutter/material.dart';
import 'package:pas_android/Component/text_field_widget.dart';
import 'package:pas_android/api/api_auth.dart';
import 'package:pas_android/otp.dart';
import 'package:provider/provider.dart';

class Register2 extends StatelessWidget {
  const Register2({super.key});

  Future<void> register(BuildContext context) async {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);

    final response = await controllerLoginRegister.registerUser();

    if (response.statusCode == 200) {
      controllerLoginRegister.submitLoading = false;
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Otp(),
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
                              Icons.person,
                                (text) {
                              controller.updateText(text, controller.fullnameController);
                            },
                          ),
                          myTextField(
                              controller.usernameController,
                              'Username',
                              false,
                              TextInputType.text,
                              Icons.person,
                                (text) {
                              controller.updateText(text, controller.usernameController);
                            },
                          ),
                          myTextField(
                              controller.passwordController,
                              'Password',
                              true,
                              TextInputType.visiblePassword,
                              Icons.lock,
                                (text) {
                              controller.updateText(text, controller.passwordController);
                            },
                          ),
                        controller.eror.isEmpty ? Container() : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(controller.eror,
                            style: const TextStyle(color: Colors.red,fontSize: 12),),
                        ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: ElevatedButton(
                              onPressed: controller.isButtonEnabledRegister(context) ? () async {
                                controller.submitLoading = true;
                                register(context);
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
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: controller.isButtonEnabledRegister(context) ? Colors.white : Colors.white,
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