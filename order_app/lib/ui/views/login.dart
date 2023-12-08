import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/ui/bloc/login_cubit.dart';
import 'package:order_app/ui/views/widgets/customTextField.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset("assets/images/ic_logo.png",color: ColorConstants.priceColor,),
            const Text("Foodi",style: TextStyle(color: ColorConstants.priceColor,fontFamily: 'Roboto' ,fontSize: 42,fontWeight: FontWeight.w500)),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: ColorConstants.priceColor,fontWeight: FontWeight.w500),),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
            ),
            CustomTextField(obscureText: false, hintText: "E-mail", icon: const Icon(Icons.mail_outline,color: ColorConstants.priceColor),controller: emailController,),
            CustomTextField(obscureText: true, hintText: "Password", icon: const Icon(Icons.lock_outline,color: ColorConstants.priceColor),controller: passwordController),
            TextButton(onPressed: () {
              context.read<LoginCubit>().login(emailController.text, passwordController.text, context);

            },style: TextButton.styleFrom(backgroundColor: ColorConstants.priceColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                child: Container(width: 300,child: const Text("Login",style: TextStyle(color: ColorConstants.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Dont have an account?",style: TextStyle(color: ColorConstants.priceColor,fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.normal),),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Registration(),));
                }, child: const Text("Sign up",style: TextStyle(color: ColorConstants.priceColor,fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w500),))

              ],
            ),

          ],
        ),
      ),
    );
  }
}

