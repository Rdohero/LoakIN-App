import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
    var controllerProduct = Provider.of<ControllerProduct>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: FutureBuilder<void>(
        future: controllerProduct.searchProduct(query),
        builder: (context, snapshot) {
          if (controllerProduct.isLoadingSearch) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            if (controllerProduct.searchProductData.isEmpty) {
              return const Center(child: Text("Tidak ada Product"));
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
                              controllerProduct.index = index;
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