import 'package:flutter/material.dart';

Widget accountButton(onPressed, IconData icon, String text,) {
  return Padding(
    padding: const EdgeInsets.only(left: 20,bottom: 25),
    child: GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.blue,),
          const SizedBox(width: 10,),
          Text(text,style: const TextStyle(color: Colors.black,fontSize: 16,),)
        ],
      ),
    ),
  );
}