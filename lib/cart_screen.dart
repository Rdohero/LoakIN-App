import 'package:flutter/material.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:provider/provider.dart';

import 'api/api_utama.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Keranjang",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'SFProDisplay'),
        ),
        leadingWidth: 100,
      ),
      body: Consumer2<ControllerCart, ControllerListUser>(
        builder: (context, controller,userController, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                        onPressed: () {  },
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
                ),
                controller.cartData.isEmpty
                ? const Center(child: Text("Tidak Ada Keranjang"),)
                : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.cartData.length,
                    itemBuilder: (context, index) {
                    var cart = controller.cartData[index];
                    var user = userController.userById[0];
                      return Column(
                        children: [
                          Dismissible(
                            onDismissed: (direction) async {
                              await controller.deleteCart(user.id, cart.productId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Berhasil Menghapus Kerangjang")),
                              );
                            },
                            key: Key(cart.id.toString()),
                            background: deleteBgItem(),
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
                                    value: controller.isChecked,
                                    onChanged: (value) {
                                      controller.isCheckedChange = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 50, color: Color(0xFFBBBBBB), thickness: 1, indent: 15, endIndent: 15,),
                        ],
                      );
                    }
                ),
              ],
            ),
          );
        }
        )
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