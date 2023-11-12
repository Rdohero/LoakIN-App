import 'package:flutter/material.dart';

Widget buttonGoBuk(onPressed, screenWidth, Text text, icon) {
  return ElevatedButton.icon(
    onPressed: () {onPressed;},
    icon: icon,
    label: text,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: const Color(0xFFEEEEEE), shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
      elevation: 0,
      minimumSize: Size(screenWidth * 0.45, 38),
    ),
  );
}