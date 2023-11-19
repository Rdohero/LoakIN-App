import 'package:flutter/cupertino.dart';

class CarouselIndex extends ChangeNotifier {
  int activeIndex = 0;

  void change(index) {
    activeIndex = index;
    notifyListeners();
  }
}