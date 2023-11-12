import 'package:flutter/material.dart';
import 'package:pas_android/Component/text_field_widget.dart';
import 'package:pas_android/api/api_login_register.dart';
import 'package:pas_android/otp.dart';
import 'package:provider/provider.dart';

class Register2 extends StatelessWidget {
  const Register2({super.key});

  bool isButtonEnabled(BuildContext context) {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);
    return controllerLoginRegister.fullnameController.text.isNotEmpty && controllerLoginRegister.usernameController.text.isNotEmpty && controllerLoginRegister.emailController.text.isNotEmpty && controllerLoginRegister.passwordController.text.isNotEmpty;
  }

  Future<void> register(BuildContext context) async {
    var controllerLoginRegister = Provider.of<ApiLoginRegister>(context, listen: false);

    final response = await controllerLoginRegister.registerUser();

    if (response.statusCode == 200) {
      controllerLoginRegister.passwordController.text = "";
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Otp(),
        ),
      );
      final error = controllerLoginRegister.tok;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      final error = controllerLoginRegister.eror;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text(error)),
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
                        controllerLoginRegister.fullnameController,
                        'Name',
                        false,
                        TextInputType.text,
                        Icons.person
                    ),
                    myTextField(
                        controllerLoginRegister.usernameController,
                        'Username',
                        false,
                        TextInputType.text,
                        Icons.person
                    ),
                    myTextField(
                        controllerLoginRegister.passwordController,
                        'Password',
                        true,
                        TextInputType.visiblePassword,
                        Icons.lock
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled(context) ? () => {
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
        ),
      ),
    );
  }
}