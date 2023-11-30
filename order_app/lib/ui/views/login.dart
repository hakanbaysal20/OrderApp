import 'dart:ui';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                  Color(0xFFFF1843),
                  Color(0xFFFF607D),
              ],
            ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Image.asset("assets/images/ic_logo.png"),
              Text("Foodi",style: TextStyle(color: Colors.white,fontFamily: 'Roboto' ,fontSize: 42)),
              Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: Colors.white),),
              Padding(
                padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0,top: 48.0),
                child: SizedBox(
                  width: 340,
                  height: 50,
                  child: TextField(decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    prefixIcon: Icon(Icons.person,color: Colors.white,),
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 18),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2),borderRadius: BorderRadius.circular(37)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(37)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0,left: 16.0,top: 16.0,bottom: 32.0),
                child: SizedBox(
                  height: 50,
                  width: 340,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: Icon(Icons.lock,color: Colors.white,),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(37)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2),borderRadius: BorderRadius.circular(37)),
                    ),
                  ),
                ),
              ),
              TextButton(onPressed: () {
              },
                  style: TextButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37))),
                  child: Container(width: 300,child: Text("Login",style: TextStyle(color: Color(0xFFFE5045)),textAlign: TextAlign.center))),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Dont have an account?",style: TextStyle(color: Colors.white,fontSize: 20),),
                  TextButton(onPressed: () {

                  }, child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 20),))

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
