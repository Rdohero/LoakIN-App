import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:pas_android/Component/account.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/settings.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var connectivityController = Provider.of<ConnectivityStatus>(context, listen: true);
    return Scaffold(
      appBar: connectivityController == ConnectivityStatus.Wifi ||
          connectivityController == ConnectivityStatus.Celluler
          ? AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Pengguna", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
      )
      : null,
      body: Consumer2<ControllerListUser, GoogleController>(
          builder: (BuildContext context, controller, controllerGoogle, child) {
            late var userGoogle = controllerGoogle.user;
            late var user = controller.userById;
            late var loading = user.isNotEmpty ? controller.isLoading : controllerGoogle.isLoading;
            return connectivityController == ConnectivityStatus.Wifi ||
                connectivityController == ConnectivityStatus.Celluler
                ? loading
                ? Center(child: Lottie.asset('assets/animations/loading.json',width: 100,height: 100),)
                : Center(
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => FadeInAnimation(
                      duration: const Duration(milliseconds: 1000),
                      child: widget,
                    ),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 15),
                                child: ClipOval(
                                  child: user.isNotEmpty ? SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: user[0].foto.isNotEmpty
                                        ? Image(
                                      image: NetworkImage("${Api.baseUrl}/${user[0].foto}"),
                                      fit: BoxFit.cover,
                                    )
                                        : const Icon(
                                      Icons.account_circle,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                  )
                                      : SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: userGoogle?.photoURL != null
                                        ? Image(
                                      image: NetworkImage(userGoogle!.photoURL.toString()),
                                      fit: BoxFit.cover,
                                    )
                                        : const Icon(
                                      Icons.account_circle,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children: [
                                  Text(user.isNotEmpty ? user[0].fullname : (userGoogle?.displayName).toString(),style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
                                  Text(user.isNotEmpty ? user[0].username : "",style: const TextStyle(color: Colors.black,fontSize: 14,),),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,bottom: 15),
                            child: Row(
                              children: [
                                const Icon(Icons.email, size: 15),
                                const SizedBox(width: 5,),
                                Text(user.isNotEmpty ? user[0].email : (userGoogle?.email).toString(),style: const TextStyle(color: Colors.black,fontSize: 14,),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 15, color: Color(0xFFBBBBBB), thickness: 2, ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 20),
                        child: Column(
                          children: [
                            accountButton(
                                    () {},
                                Icons.favorite_border_rounded,
                                "Favorite"
                            ),
                            accountButton(
                                    () {},
                                Icons.account_balance_wallet,
                                "Saldo"
                            ),
                            accountButton(
                                    () {},
                                Icons.shopping_cart,
                                "Keranjang"
                            ),
                            accountButton(
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Settings()),
                                  );
                                },
                                Icons.settings,
                                "Settings"
                            ),
                            accountButton(
                                    () {},
                                Icons.question_mark,
                                "FAQ"
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 15, color: Color(0xFFBBBBBB), thickness: 2, ),
                    ],
                  ),
                ),
              )
            )
                : Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset('assets/animations/no_internet.json'),
              ),
            );
          }
      ),
    );
  }
}