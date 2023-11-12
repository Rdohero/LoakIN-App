import 'package:flutter/material.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/model/product_model.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerProduct = Provider.of<ControllerProduct>(context, listen: false);
    var controllerCart = Provider.of<ControllerCart>(context, listen: false);
    var controllerUser = Provider.of<ControllerListUser>(context, listen: false);
    late var product = controllerProduct.productData[controllerProduct.index.toInt()];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Product", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
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
      ),
      body: controllerProduct.isLoading ? const Center(child: CircularProgressIndicator(color: Colors.blue,)) : detailProduct(controllerProduct),
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  child: Text(
                    moneyFormat(product.price).text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return checkout(context,product,controllerCart, controllerUser, controllerProduct);
                    }
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white, backgroundColor: const Color(0xFFD9D9D9), shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                minimumSize: const Size(50, 30),
              ),
              child: const Text(
                'Check Out',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget detailProduct(ControllerProduct controllerProduct) {
  late var product = controllerProduct.productData[controllerProduct.index.toInt()];
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("${Api.baseUrl}/${product.image}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12,top: 20),
              width: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                  const SizedBox(height: 10,),
                  Text(moneyFormat(product.price).text, style: const TextStyle(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(Icons.location_pin, color: Color(0xFFFF2626),size: 13),
                      Text(product.location),
                    ]
                    ,)
                ],
              ),
            ),
            const Expanded(child: Icon(Icons.favorite_border, color: Colors.blue,))
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 15, top: 20),
            child: const Text("Product Details", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
        ),
        Container(
            margin: const EdgeInsets.only(left: 15,top: 15),
            child: Text(product.description)
        ),
      ],
    ),
  );
}

Widget checkout(context,Product product, ControllerCart controllerCart, ControllerListUser controllerUser, ControllerProduct controllerProduct) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
      ),
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 161,
                height: 129,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${Api.baseUrl}/${product.image}"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(moneyFormat(product.price).text),
                  Text("stock"),
              ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFF7B7B7B),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final response = await controllerCart.addNewCart(controllerUser.userById[0].id, product.id, controllerProduct.quantity);
              Navigator.pop(context);
              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Berhasil Menambah Kerangjang")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Gagal Menambah Kerangjang")),
                );
              }
            },
            child: Container(
              width: 100,
              color: Colors.transparent,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Check Out", style: TextStyle(fontSize: 15),),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}