import 'package:flutter/material.dart';
import 'package:pas_android/api/navigator_provider.dart';
import 'package:pas_android/cart_screen.dart';
import 'package:pas_android/home.dart';
import 'package:pas_android/profile.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatelessWidget {
  BottomNavigator({super.key});

  final screens = [
    Home(),
    const CartScreen(),
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
        unselectedItemColor: const Color(0xFF0479CD),
        selectedItemColor: const Color(0xFF0479CD),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_rounded,
            ),
            label: "Keranjang",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Pengguna",
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}