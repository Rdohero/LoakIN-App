import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_android/api/api_utama.dart';
import 'package:pas_android/api/user_api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ControllerListUser controller = Get.put(ControllerListUser());
  int activeIndex = 0;

  final urlImages = [
    'https://dotesports.com/wp-content/uploads/2023/07/kafka-smiling-honkai-star-rail.jpg',
    'https://assets.kompasiana.com/items/album/2021/10/01/eula-lawrence-6156077306310e70c73c02d2.jpg?t=o&v=740&x=416',
  ];

  void Slider(activeIndex, index) {
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
      late var user = controller.userById[0];
      return controller.isLoading.value ? const CircularProgressIndicator() : SingleChildScrollView(
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
                  height: 160,
                  onPageChanged: (index, reason) => setState(() => activeIndex = index)
              ),
              itemBuilder: (context, index ,realIndex){
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              },
            ),
            const SizedBox(height: 12,),
            Center(child: buildIndicator()),
          ],
        ),
      );
    },
    ),
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

