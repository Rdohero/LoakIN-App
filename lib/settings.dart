import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pas_android/Component/button_setting.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/bottom_navigator.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ControllerListUser, GoogleController, ConnectivityStatus>(
        builder: (BuildContext context, controller, controllerGoogle, connectivity, child) {
          late var userGoogle = controllerGoogle.user;
          late var user = controller.userById[0];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text("Akun Saya", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
              leadingWidth: 100,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    controller.returnedImage = null;
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: Color(0xFF2691DF),size: 15,),
                      Text("kembali",style: TextStyle(color: Color(0xFF2691DF)),),
                    ],
                  ),
                ),
              ),
              actions: [
                connectivity == ConnectivityStatus.Wifi ||
                    connectivity == ConnectivityStatus.Celluler
                    ? controller.userById.isNotEmpty
                    ? Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () async {
                        final response = await controller.updatePhotoUserData();
                        if (response.statusCode == 200) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigator()),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          color: Color(0xFFEE4D2D),
                        ),
                      ),
                    );
                  },
                )
                    : Container()
                    : Container(),
              ],
            ),
            body: connectivity == ConnectivityStatus.Wifi ||
                connectivity == ConnectivityStatus.Celluler
                ? controller.userById.isNotEmpty
                ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 15),
                  child: GestureDetector(
                    onTap: () async {
                      controller.pickImage(await ImagePicker().pickImage(source: ImageSource.gallery));
                    },
                    child: ClipOval(
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: controller.returnedImage2 != null
                            ? Image(
                          image: FileImage(File(controller.returnedImage2!.path)),
                          fit: BoxFit.cover,
                        )
                            : user.foto.isNotEmpty
                            ? Image(
                          image: NetworkImage("${Api.baseUrl}/${user.foto}"),
                          fit: BoxFit.cover,
                        )
                            : const Icon(
                          Icons.account_circle,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                buttonApi( const Settings(), user.username, "Username", context),
                buttonApi( const Settings(), user.fullname, "Nama", context),
                buttonApi( const Settings(), user.email, "Email", context),
                buttonApi( const Settings(), "*********", "Password", context),
                const Divider(color: Color(0xFFBBBBBB), height: 50, thickness: 3),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        await pref.clear();
                        controller.userById.clear();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        const SplashScreen()), (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF212121)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 15),
                  child: ClipOval(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: userGoogle?.photoURL != null
                          ? Image(
                        image: NetworkImage(userGoogle!.photoURL.toString()),
                        fit: BoxFit.cover,
                      )
                          : const Icon(
                        Icons.account_circle,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                buttonApi( const Settings(), (userGoogle?.displayName).toString(), "Nama", context),
                buttonApi( const Settings(), (userGoogle?.email).toString(), "Email", context),
                buttonApi( const Settings(), "*********", "Password", context),
                const Divider(color: Color(0xFFBBBBBB), height: 50, thickness: 3),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        await pref.clear();
                        controller.userById.clear();
                        controllerGoogle.signOut();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        const SplashScreen()), (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF212121)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset('assets/animations/no_internet.json'),
              ),
            ),
          );
        }
    );
  }
}

