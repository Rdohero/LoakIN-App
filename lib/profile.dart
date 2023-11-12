import 'package:flutter/material.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ControllerListUser>(context, listen: false);
    return Scaffold(
      body: profile(controller,context),
    );
  }
}

Widget profile(controller, BuildContext context) {
  late var user = controller.userById[0];
  return controller.isLoading
        ? const CircularProgressIndicator()
        : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Under Maintance!!!", style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 15),
                child: ClipOval(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: user.foto.isNotEmpty
                        ? Image(
                      image: NetworkImage("${Api.baseUrl}/${user.foto}"),
                      fit: BoxFit.cover,
                    )
                        : const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Text(user.fullname,style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
              Text(user.username,style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
              Text(user.email,style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      await pref.clear();
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
          ),
        );
}
