import 'package:flutter/material.dart';
import 'package:pas_android/api/navigator_provider.dart';
import 'package:pas_android/cart_screen.dart';
import 'package:pas_android/home.dart';
import 'package:pas_android/pengiriman.dart';
import 'package:pas_android/profile.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatelessWidget {
  BottomNavigator({super.key});

  final screens = [
    const Home(),
    const CartScreen(),
    const Pengiriman(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    var currentIndex = Provider.of<BottomNavigationProvider>(context).currentIndex;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          Provider.of<BottomNavigationProvider>(context, listen: false).currentIndex = value;
        },
        backgroundColor: Colors.white,
        selectedFontSize: 10,
        unselectedIconTheme: const IconThemeData(size: 20),
        selectedIconTheme: const IconThemeData(size: 20),
        unselectedItemColor: const Color(0xFF0479CD),
        selectedItemColor: const Color(0xFF0479CD),
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            activeIcon: ImageIcon(AssetImage("assets/images/icons_images/home_icon.png")),
            icon: ImageIcon(AssetImage("assets/images/icons_images/home.png")),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(AssetImage("assets/images/icons_images/keranjang_icon.png")),
            icon: ImageIcon(AssetImage("assets/images/icons_images/keranjang.png")),
            label: "Keranjang",
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(AssetImage("assets/images/icons_images/pengiriman_icon.png")),
            icon: ImageIcon(AssetImage("assets/images/icons_images/pengiriman.png")),
            label: "Pengiriman",
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(AssetImage("assets/images/icons_images/pengguna_icon.png")),
            icon: ImageIcon(AssetImage("assets/images/icons_images/pengguna.png")),
            label: "Pengguna",
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}