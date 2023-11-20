import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pas_android/Component/account.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/settings.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text("Pengguna", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
      ),
      body: Consumer<ControllerListUser>(
          builder: (BuildContext context, controller,child) {
            late var user = controller.userById[0];
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
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
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: user.foto.isNotEmpty
                                        ? Image(
                                      image: NetworkImage("${Api.baseUrl}/${user.foto}"),
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
                                  Text(user.fullname,style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
                                  Text(user.username,style: const TextStyle(color: Colors.black,fontSize: 14,),),
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
                                Text(user.email,style: const TextStyle(color: Colors.black,fontSize: 14,),)
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
              ),
            );
          }
      ),
    );
  }
}