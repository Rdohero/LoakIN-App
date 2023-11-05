import 'package:flutter/material.dart';

Widget myTextField(TextEditingController controller, String myLabel, bool obscure, TextInputType text,IconData iconData) {
  return Container(
    margin: const EdgeInsets.only(top: 5, right: 30, left: 30,bottom: 5),
    child: TextField(
      style: const TextStyle(color: Colors.black, fontSize: 15),
      autofocus: false,
      controller: controller,
      obscureText: obscure,
      keyboardType: text,
      decoration: InputDecoration(
        fillColor: const Color(0xFFEDF1FF),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: myLabel,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(iconData, color: Colors.grey,size: 23,),
      ),
    ),
  );
}