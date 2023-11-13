import 'package:flutter/material.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<ControllerCart>(context, listen: false);
    var userController = Provider.of<ControllerListUser>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Keranjang", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (cartController.cartData.isEmpty)
              const Center(
                child: Text(
                  "Keranjang tidak ada",
                  style: TextStyle(fontSize: 18),
                ),
              )
            else
              ListView.builder(
                itemCount: cartController.cartData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final cart = cartController.cartData[index];
                  final totalPrice = moneyFormat(cart.product.price * cart.quantity);
                  return Dismissible(
                    onDismissed: (direction) async {
                      final response = await cartController.deleteCart(userController.userById[0].id, cart.product.id);
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Berhasil Menghapus Keranjang")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gagal Menghapus Kerangjang")),
                        );
                      }
                    },
                    key: Key(cart.id.toString()),
                    background: deleteBgItem(),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text(cart.product.name),
                          Text("Total Harga : ${totalPrice.text}"),
                          Text("Banyak : ${cart.quantity}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
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
