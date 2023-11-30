import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/ui/bloc/login_cubit.dart';
import 'package:order_app/ui/views/customTextField.dart';
import 'package:order_app/ui/views/registration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  ColorConstants.gradientColor,
                  ColorConstants.gradientColorLight,
              ],
            ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Image.asset("assets/images/ic_logo.png"),
              const Text("Foodi",style: TextStyle(color: ColorConstants.white,fontFamily: 'Roboto' ,fontSize: 42,fontWeight: FontWeight.w500)),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: ColorConstants.white,fontWeight: FontWeight.w500),),
              ),
              CustomTextField(obscureText: false, hintText: "E-mail", icon: const Icon(Icons.mail_outline,color: ColorConstants.white),controller: emailController,),
              CustomTextField(obscureText: true, hintText: "Password", icon: const Icon(Icons.lock_outline,color: ColorConstants.white),controller: passwordController),
              TextButton(onPressed: () {
                context.read<LoginCubit>().login(emailController.text, passwordController.text, context);

              },style: TextButton.styleFrom(backgroundColor: ColorConstants.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37))),
                  child: Container(width: 300,child: const Text("Login",style: TextStyle(color: ColorConstants.buttonTextColor,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Dont have an account?",style: TextStyle(color: ColorConstants.white,fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.normal),),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Registration(),));
                  }, child: const Text("Sign up",style: TextStyle(color: ColorConstants.white,fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.normal),))

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

