import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:pas_android/Connectivity/conectivity_status.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/home.dart';
import 'package:pas_android/product_screen.dart';
import 'package:provider/provider.dart';

class SearchProduct extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var connectivityController = Provider.of<ConnectivityStatus>(context, listen: true);
    var controllerProduct = Provider.of<ControllerProduct>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: FutureBuilder<void>(
        future: controllerProduct.searchProduct(query),
        builder: (context, snapshot) {
          if (connectivityController == ConnectivityStatus.Wifi ||
              connectivityController == ConnectivityStatus.Celluler) {
            if (controllerProduct.isLoadingSearch) {
              return Center(child: Lottie.asset('assets/animations/loading.json',width: 100,height: 100),);
            } else {
              if (controllerProduct.searchProductData.isEmpty) {
                return Center(child: Lottie.asset('assets/animations/no_search.json'),);
              } else {
                return AnimationLimiter(
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1/1.25,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      controllerProduct.searchProductData.length,
                          (index){
                        final searchProduct = controllerProduct.searchProductData[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            child: SlideAnimation(
                              child: ProductItem(product: searchProduct, onPressed: () {
                                controllerProduct.getByProductId(searchProduct.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProductScreen()),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset('assets/animations/no_internet.json'),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search Product"),
    );
  }
  
}