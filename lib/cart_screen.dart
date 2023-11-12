import 'package:flutter/material.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<ControllerCart>(context, listen: false);
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
            ListView.builder(
              itemCount: cartController.cartData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final cart = cartController.cartData[index];
                final totalPrice = moneyFormat(cart.product.price * cart.quantity);
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    Text(cart.product.name),
                    Text("Total Harga : ${totalPrice.text}"),
                    Text("Banyak : ${cart.quantity}"),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
