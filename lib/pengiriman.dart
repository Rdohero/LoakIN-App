import 'package:flutter/material.dart';
import 'package:pas_android/Checkout%20All/metode_pembayaran_screen.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/invoice_api.dart';
import 'package:pas_android/api/payment_controller.dart';
import 'package:provider/provider.dart';

class Pengiriman extends StatelessWidget {
  const Pengiriman({super.key});

  @override
  Widget build(BuildContext context) {
    var connectivityController = Provider.of<ConnectivityStatus>(context, listen: true);
    return Consumer2<InvoiceController, PaymentController>(
        builder: (context, controllerInvoice, controllerPayment, child) {
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
                "Pengiriman",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'SFProDisplay'),
              ),
              leadingWidth: 100,
            )
                :  null,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: controllerInvoice.isSelect ? () async {
                            controllerInvoice.isSelect = false;
                            await controllerInvoice.filterInvoicesByStatus(1);
                          } : null ,
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: const Color(0xFFA8A8A8),
                            foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                          child: const Text(
                            'Belum Dibayar',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: !controllerInvoice.isSelect ? () async {
                            controllerInvoice.isSelect = true;
                            await controllerInvoice.filterInvoicesByStatus(2);
                          } : null,
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: const Color(0xFFA8A8A8),
                            foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D5D97), shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                          child: const Text(
                            'Sudah Dibayar',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                controllerInvoice.invoiceStatus.isNotEmpty ? ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controllerInvoice.invoiceStatus.length,
                    itemBuilder: (context, index){
                      var invoiceStatus = controllerInvoice.invoiceStatus[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 110,
                                  width: 115,
                                  margin: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage("${Api.baseUrl}/${invoiceStatus.invoiceItems[0].product.image}"), fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,),
                                        child: Text(
                                          invoiceStatus.invoiceItems[0].product.name.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'SFProDisplay',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          "${invoiceStatus.invoiceItems[0].quantity} barang",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontFamily: 'SFProDisplay',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 5),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Total pembelian : ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(255, 0, 0, 0),
                                                fontFamily: 'SFProDisplay',
                                              ),
                                            ),
                                            Text(
                                              moneyFormat(invoiceStatus.totalAmount).text,
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
                          const Divider(height: 25, color: Color(0xFFBBBBBB), thickness: 1,),
                          Text(invoiceStatus.status.status),
                          invoiceStatus.statusId == 1 ? ElevatedButton(
                            onPressed: () async {
                              controllerPayment.selectInvoice = invoiceStatus.id;
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => const PaymentScreen()),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              foregroundColor: Colors.blue, backgroundColor: Colors.blue, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                              minimumSize: const Size(50, 30),
                            ),
                            child: const Text(
                              'Bayar !',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ) : Container(),
                          const Divider(height: 20, color: Color(0xFFBBBBBB), thickness: 1,),
                        ],
                      );
                    }
                )
                    : const Text("Tidak ada Pesanan", style: TextStyle(color: Colors.black, fontSize: 20),),
              ],
            ),
          );
        }
    );
  }
}
