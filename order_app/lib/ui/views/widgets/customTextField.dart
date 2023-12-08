
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  bool obscureText;
  String hintText;
  Icon icon;
  TextEditingController? controller;
  CustomTextField({required this.obscureText,required this.hintText,required this.icon,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 340,
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.black54,fontFamily: 'Roboto',fontWeight: FontWeight.w500,fontSize: 18),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15),
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