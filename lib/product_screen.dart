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
    var controllerProduct = Provider.of<ControllerProduct>(context, listen: true);
    var controllerCart = Provider.of<ControllerCart>(context, listen: true);
    var controllerUser = Provider.of<ControllerListUser>(context, listen: true);
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
              controllerCart.counter2 = 1;
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
        height: 65,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                minimumSize: const Size(50, 30),
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 20,
                color: Colors.blue,
              ),
            ),
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1.0,
              indent: 10,
              endIndent: 10,
            ),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white, backgroundColor: Colors.white, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                minimumSize: const Size(50, 30),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
      ),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Consumer<ControllerCart>(
                builder: (context, controllerCart, child) {
                  final totalPrice = moneyFormat(product.price * controllerCart.counter);
                  return Text(
                    totalPrice.text,
                    style: const TextStyle(color: Colors.blue),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
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
          Center(
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.remove, size: 15,color: Colors.blue,),
                      onPressed: () => controllerCart.decrement(),
                    ),
                  ),
                  Expanded(
                    child: Consumer<ControllerCart>(
                      builder: (context, controllerCart, child) {
                        return Text(
                          '${controllerCart.counter}',
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 15,color: Colors.blue,),
                      onPressed: () => controllerCart.increment(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () async {
                final response = await controllerCart.addNewCart(controllerUser.userById[0].id, product.id, controllerCart.counter);
                Navigator.pop(context);
                if (response.statusCode == 200) {
                  controllerCart.counter2 = 1;
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Di tambahkan Ke Keranjang !"),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      contentTextStyle: const TextStyle(fontSize: 15,color: Colors.black),
                    ),
                  );
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Gagal Menambah Kerangjang"),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      contentTextStyle: const TextStyle(fontSize: 15,color: Colors.black),
                    ),
                  );
                }
              },
              child: Container(
                color: Colors.transparent,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Tambah Keranjang", style: TextStyle(fontSize: 15),),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}