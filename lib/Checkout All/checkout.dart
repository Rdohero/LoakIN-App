import 'package:flutter/material.dart';
import 'package:pas_android/Checkout%20All/metode_pembayaran_screen.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/payment_controller.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer6<ControllerCart, ControllerListUser, ControllerProduct, GoogleController, ControllerListUser, InvoiceController>(
        builder: (context, controllerCart, userController, controllerProduct, googleController, controllerUser, controllerInvoice, child) {
          var connectivityController = Provider.of<ConnectivityStatus>(context, listen: true);
          var controllerPayment = Provider.of<PaymentController>(context, listen: true);
          int? userGoogle = googleController.user?.uid.hashCode;
          var user = controllerUser.userById;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
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
              title: const Text("Beli Sekarang !", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black, fontSize: 20),),
              leadingWidth: 75,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: Color(0xFF2691DF),size: 12,),
                      Text("kembali",style: TextStyle(color: Color(0xFF2691DF),fontSize: 13),),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageIcon(AssetImage("assets/images/icons_images/kupon.png"),color: Color(0xFF057ACE),),
                          SizedBox(width: 15,),
                          Text("Gunakan Kode Promo atau Kupon",style: TextStyle(color: Color(0xFF057ACE)),)
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0, color: Color(0xFFBBBBBB), thickness: 1,),
                  const SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Alamat Pengiriman", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF057ACE),),)),
                      )
                  ),
                  const Divider(height: 0, color: Color(0xFFBBBBBB), thickness: 1,endIndent: 23,indent: 23,),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          const Text("Maman Maulana"),
                          const SizedBox(height: 10,),
                          const Text("08129394833094"),
                          const SizedBox(height: 10,),
                          const Text("Apartemen Ula Ilu Tower Melati Lantai 8 No.44 Jl. Kacang Kapri Muda Kav. 13 Utan Kayu Selatan, Matraman, Jakarta Timur, Indonesia, 13120"),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                    shadowColor: const Color(0xFF2683C6),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    maximumSize: const Size(150, 60)
                                ),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  'Konfirmasi Pengiriman',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                    shadowColor: const Color(0xFF2683C6),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    maximumSize: const Size(150, 60),
                                ),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  'Pilih Alamat Lain',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0, color: Color(0xFFBBBBBB), thickness: 1,endIndent: 23,indent: 23,),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20,bottom: 70),
                      itemCount: controllerCart.selectedCarts.length,
                      itemBuilder: (context, index) {
                        var selectedCarts = controllerCart.selectedCarts[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,bottom: 15),
                              child: Text("Penjual : ${selectedCarts.product.user.username}", style: const TextStyle(fontWeight: FontWeight.w500),),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 110,
                                  width: 110,
                                  margin: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage("${Api.baseUrl}/${selectedCarts.product.image}"), fit: BoxFit.fill),
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
                                          selectedCarts.product.name.toString(),
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
                                          "${selectedCarts.quantity} barang",
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
                                          moneyFormat(controllerCart.calculatePrice(selectedCarts.quantity, selectedCarts.product.price)).text,
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
                                              selectedCarts.product.location,
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
                            const SizedBox(height: 20,),
                          ],
                        );
                      }
                  ),
                ],
              ),
            ),
            bottomSheet: connectivityController == ConnectivityStatus.Wifi ||
                connectivityController == ConnectivityStatus.Celluler
                ? Container(
              width: double.infinity,
              height: 80,
              decoration: const ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Pembayaran",style: TextStyle(color: Color(0xFF7B7B7B),fontSize: 14),),
                        Text(moneyFormat(controllerCart.calculateTotalPrice()).text,style: const TextStyle(color: Colors.blue,fontSize: 16),),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await controllerInvoice.checkoutMultipleProducts(controllerUser.userById.isNotEmpty ? user[0].id : userGoogle!, context, controllerCart.calculateTotalPrice(), "Apartemen Ula Ilu Tower Melati Lantai 8 No.44 Jl. Kacang Kapri Muda Kav. 13 Utan Kayu Selatan, Matraman, Jakarta Timur, Indonesia, 13120", controllerPayment);
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const PaymentScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: const Color(0xFF2683C6),
                      elevation: 0,
                      foregroundColor: const Color(0xFF2683C6), backgroundColor: const Color(0xFF2683C6), shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      minimumSize: const Size(0 , 40),
                    ),
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Checkout',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ) : null,
          );
        }
    );
  }
}

