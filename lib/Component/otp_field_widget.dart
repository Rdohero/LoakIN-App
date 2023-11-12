import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 60,
  textStyle: const TextStyle(
    fontSize: 22,
    color: Colors.black,
  ),
  decoration: BoxDecoration(
    color: const Color(0xFFEDF1FF),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.transparent),
  ),
);
