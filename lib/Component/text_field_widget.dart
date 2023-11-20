import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget myTextField(TextEditingController controller, String myLabel, bool obscure, TextInputType text,IconData iconData,Function(String)? onChanged) {
  return Container(
    margin: const EdgeInsets.only(top: 5, right: 30, left: 30,bottom: 5),
    child: AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          childAnimationBuilder: (widget) => SlideAnimation(
            duration: const Duration(milliseconds: 1000),
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            TextField(
              style: const TextStyle(color: Colors.black, fontSize: 14),
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
              onChanged: onChanged,
            )
          ],
        ),
      ),
    ),
  );
}