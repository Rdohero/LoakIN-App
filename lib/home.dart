import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pas_android/Component/money_format.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/model/product_model.dart';
import 'package:pas_android/api/product_api.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:pas_android/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatelessWidget {
  Home({super.key});

  int activeIndex = 0;

  final urlImages = [
    'https://dotesports.com/wp-content/uploads/2023/07/kafka-smiling-honkai-star-rail.jpg',
    'https://assets.kompasiana.com/items/album/2021/10/01/eula-lawrence-6156077306310e70c73c02d2.jpg?t=o&v=740&x=416',
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ControllerListUser>(context, listen: false);
    var controllerProduct = Provider.of<ControllerProduct>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    late var user = controller.userById[0];
    return Scaffold(
        body:
        controller.isLoading ? const CircularProgressIndicator() : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 25,
                decoration: const BoxDecoration(color: Color(0xFF0479CD)),),
              Container(
                width: double.infinity,
                height: 150,
                decoration: const BoxDecoration(color: Color(0xFF0479CD)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.65,
                          child: const Text(
                            'Welcome back 🙌',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: user.foto.isNotEmpty
                                ? Image(
                              image: NetworkImage("${Api.baseUrl}/${user.foto}"),
                              fit: BoxFit.cover,
                            )
                                : const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.search,size: 20,),
                                  hintText: "Barang murah berkualitas",
                                  hintStyle: TextStyle(fontSize: 13),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.2,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_none,color: Colors.white,size: 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15,left: 20),
                child: Text("Location"),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15,top: 5),
                child: Row(
                  children: [
                    Icon(Icons.location_pin,color: Colors.red,),
                    Text("Kudus, Bestio",style: TextStyle(fontFamily: "SFProDisplay", fontWeight: FontWeight.normal),),
                    Icon(Icons.arrow_drop_down,color: Colors.black,)
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              CarouselSlider.builder(
                itemCount: urlImages.length,
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: const Duration(seconds: 4),
                    aspectRatio: 2.3/1,
                    onPageChanged: (index, reason) =>  activeIndex = index
                ),
                itemBuilder: (context, index ,realIndex){
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                },
              ),
              const SizedBox(height: 12,),
              Center(child: buildIndicator()),
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Container(
                  margin: const EdgeInsets.only(right: 23,left: 23),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jelajahi produk terbaru kami", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        Text("see all", style: TextStyle(fontSize: 12),),
                      ]
                  ),
                ),
              ),
              listProduct(controllerProduct,context),
              const SizedBox(height: 50,),
            ],
          ),
        )
    );
  }
  Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: const WormEffect(type: WormType.thin, dotWidth: 8,dotHeight: 8, activeDotColor: Colors.blue),
      activeIndex: activeIndex,
      count: urlImages.length
  );
}

Widget buildImage(String urlImage, int index) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.network(urlImage, fit: BoxFit.cover),
  );
}


Widget listProduct(ControllerProduct controllerProduct,BuildContext context) {
  return controllerProduct.isLoading
      ? const CircularProgressIndicator()
      : GridView.count(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    crossAxisCount: 2,
    childAspectRatio: 1/1.25,
    crossAxisSpacing: 10,
    physics: const NeverScrollableScrollPhysics(),
    children: List.generate(
      controllerProduct.productData.length,
          (index){
        final product = controllerProduct.productData[index];
        return ProductItem(product: product, onPressed: () {
          // controllerProduct.getProductByID(product.id);
          controllerProduct.index = index;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductScreen()),
          );
        });
      },
    ),
  );
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ProductItem({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${Api.baseUrl}/${product.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(product.name,maxLines: 2,style: const TextStyle(fontSize: 11),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 4),
              child: Text(moneyFormat(product.price).text,style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10),),
            ),
            Padding(
              padding:  const EdgeInsets.only(top: 4,left: 2),
              child: Row(
                children: [
                  const Icon(Icons.location_pin, color: Color(0xFFFF2626),size: 10),
                  Text(product.location, style: const TextStyle(fontSize: 10),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
