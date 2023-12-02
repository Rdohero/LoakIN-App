import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pas_android/Checkout%20All/checkout.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/product_screen.dart';
import 'package:provider/provider.dart';
import 'api/api_utama.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var connectivityController = Provider.of<ConnectivityStatus>(context, listen: true);
    var controllerCart= Provider.of<ControllerCart>(context, listen: false);
    var controllerUser= Provider.of<ControllerListUser>(context, listen: false);
    var controllerGoogle= Provider.of<GoogleController>(context, listen: true);

    Future<void> refresh() async {
      int userId;
      if(controllerUser.userById.isNotEmpty) {
        userId = controllerUser.userById[0].id;
        controllerCart.getCart(userId);
      } else if (controllerUser.userById.isEmpty) {
        userId = controllerGoogle.user!.uid.hashCode;
        controllerCart.getCart(userId);
      }
    }
    return Scaffold(
        appBar: connectivityController == ConnectivityStatus.Wifi ||
            connectivityController == ConnectivityStatus.Celluler
            ? AppBar(
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
            "Keranjang",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'SFProDisplay'),
          ),
          leadingWidth: 100,
        )
        :  null,
        body: Consumer4<ControllerCart, ControllerListUser, ControllerProduct, GoogleController>(
            builder: (context, controller,userController, productController, googleController, child) {
              int? userGoogle = googleController.user?.uid.hashCode;
              var user = userController.userById;
              return connectivityController == ConnectivityStatus.Wifi ||
                  connectivityController == ConnectivityStatus.Celluler
                  ? RefreshIndicator(
                onRefresh: refresh,
                child: controller.cartData.isEmpty
                    ? ListView(
                      children: [
                        Center(child: Lottie.asset('assets/animations/no_cart.json')),
                      ],
                    )
                    : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          controller.cartData.isNotEmpty ? Container(
                            margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Barang",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProDisplay',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.toggleAllSelection();
                                  },
                                  child: const Text(
                                    "Beli Semua",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SFProDisplay',
                                      fontSize: 15,
                                      color: Color(0xFF2691DF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Container(),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.cartData.length,
                              itemBuilder: (context, index) {
                                var cart = controller.cartData[index];
                                return Column(
                                  children: [
                                    Dismissible(
                                      onDismissed: (direction) async {
                                        await controller.deleteCart(userController.userById.isNotEmpty ? user[0].id : userGoogle!, cart.productId);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Berhasil Menghapus Keranjang")),
                                        );
                                      },
                                      key: Key(cart.id.toString()),
                                      background: deleteBgItem(),
                                      child: GestureDetector(
                                        onTap: () {
                                          productController.getByProductId(cart.productId);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const ProductScreen()),
                                          );
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              margin: const EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: NetworkImage("${Api.baseUrl}/${cart.product.image}"), fit: BoxFit.fill),
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
                                                      cart.product.name.toString(),
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
                                                      "${cart.quantity} barang",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        fontFamily: 'SFProDisplay',
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 5),
                                                    child: Text(
                                                      moneyFormat(cart.product.price).text,
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
                                                          cart.product.location,
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
                                            SizedBox(
                                              width: 50,
                                              child: Checkbox(
                                                activeColor: Colors.amber,
                                                value: cart.isSelected,
                                                onChanged: (value) {
                                                  controller.toggleSelection(cart);
                                                },
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
                    controller.cartData.isNotEmpty ? BottomAppBar(
                      elevation: 0,
                      height: 65,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: controller.selectedCarts.isNotEmpty ? () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Checkout()),
                              );
                            } : null,
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                              minimumSize: const Size(50, 30),
                            ),
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                fontSize: 15,
                                color: controller.selectedCarts.isNotEmpty ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container(),
                  ],
                ),
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

Widget deleteBgItem() {
  return Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20),
    color: Colors.red,
    child: const Icon(Icons.delete, color: Colors.white,),
  );
}