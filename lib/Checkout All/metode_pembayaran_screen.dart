import 'package:flutter/material.dart';
import 'package:pas_android/api/cart_api.dart';
import 'package:pas_android/api/google_controller.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/payment_controller.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/bottom_navigator.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer6<PaymentController, GoogleController, ControllerCart, InvoiceController, GoogleController, ControllerListUser>(
        builder: (context, controllerPayment, controllerGoogle, controllerCart, controllerInvoice,googleController,controllerUser,child) {
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
              title: const Text("Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 20),),
              leadingWidth: 75,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    controllerPayment.selectInvoice = 0;
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
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Pilih metode pembayaran yang ingin kamu lakukan", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controllerPayment.paymentData.length - 1,
                    itemBuilder: (context, index) {
                      var payment = controllerPayment.paymentData[index + 1];
                      return GestureDetector(
                        onTap: () {
                          controllerPayment.selectPayment(index + 1 ,payment.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controllerPayment.selectedPaymentIndex == (index + 1)  ? Colors.blue : Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            payment.payment,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                BottomAppBar(
                  elevation: 0,
                  height: 65,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controllerPayment.updatePayment(controllerPayment.selectInvoice, controllerPayment.selectedPayment, controllerInvoice, controllerUser.userById.isNotEmpty ? user[0].id : userGoogle!);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => BottomNavigator()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                          minimumSize: const Size(50, 30),
                        ),
                        child: const Text(
                          'Bayar',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
