import 'package:flutter/material.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/database/database_instance.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerFavorite= Provider.of<DatabaseInstance>(context, listen: false);
    controllerFavorite.database();

    Future<void> refresh() async {
      controllerFavorite.all();
      print(controllerFavorite.FavoriteData);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: Container(
              height: 1.0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Favorite",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'SFProDisplay'),
          ),
          leadingWidth: 100,
        ),
        body: Consumer5<ControllerCart, ControllerListUser, ControllerProduct, GoogleController,DatabaseInstance>(
            builder: (context, controller,userController, productController, googleController,controllerFavorite, child) {
              return  RefreshIndicator(
                onRefresh: refresh,
                child: controllerFavorite.FavoriteData.isEmpty
                    ? ListView(
                      children: const [
                        Center(child: Text("No Favorite")),
                      ],
                    )
                    : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controllerFavorite.FavoriteData.length,
                              padding: const EdgeInsets.only(top: 10),
                              itemBuilder: (context, index) {
                                var cart = controllerFavorite.FavoriteData[index];
                                return Column(
                                  children: [
                                    Dismissible(
                                      onDismissed: (direction) async {
                                        await controllerFavorite.delete(cart.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Berhasil Menghapus Favorite")),
                                        );
                                      },
                                      key: Key(cart.id.toString()),
                                      background: deleteBgItem(),
                                      child: GestureDetector(
                                        onTap: () {
                                          // productController.getByProductId(cart.productId);
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => const ProductScreen()),
                                          // );
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              margin: const EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: MemoryImage(cart.image!), fit: BoxFit.fill),
                                                  borderRadius: BorderRadius.circular(20)),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      left: 20,),
                                                    child: Text(
                                                      cart.name.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'SFProDisplay',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 5),
                                                    child: Text(
                                                      moneyFormat(cart.price).text,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(255, 0, 0, 0),
                                                        fontFamily: 'SFProDisplay',
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15, top: 2),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.location_on,
                                                          color: Color.fromARGB(255, 255, 38, 38),
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          cart.location!,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Color.fromARGB(255, 0, 0, 0),
                                                            fontFamily: 'SFProDisplay',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(height: 50, color: Color(0xFFBBBBBB), thickness: 1, indent: 15, endIndent: 15,),
                                  ],
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
    );
  }
}

Widget deleteBgItem() {
  return Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20),
    color: Colors.red,
    child: const Icon(Icons.delete, color: Colors.white,),
  );
}