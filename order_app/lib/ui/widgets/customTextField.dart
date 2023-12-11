
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  bool obscureText;
  String hintText;
  Icon icon;
  TextEditingController? controller;
  CustomTextField({required this.obscureText,required this.hintText,required this.icon,required this.controller});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: SizedBox(
        width: screenWidth * 0.8,
        height: screenWidth * 0.14,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.black54,fontFamily: 'Roboto',fontWeight: FontWeight.w500,fontSize: 18),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.045),
            prefixIcon: icon,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black12,fontSize: 18,fontFamily: 'Roboto'),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26),borderRadius: BorderRadius.circular(7)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
          ),
        ),
      ),
    );
  }
}