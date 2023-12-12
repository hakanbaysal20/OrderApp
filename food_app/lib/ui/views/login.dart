import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/enums/image_constants.dart';
import 'package:order_app/ui/cubit/login_cubit.dart';
import 'package:order_app/ui/views/registration.dart';
import 'package:order_app/ui/widgets/customTextField.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenWidth * 0.15),
            Image.asset(ImageConstants.appLogo.toPng),
            const Text("Foodi",style: TextStyle(color: ColorConstants.priceColor,fontFamily: 'Roboto' ,fontSize: 42,fontWeight: FontWeight.w500)),
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.04),
              child: const Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: ColorConstants.priceColor,fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.04),
            ),
            CustomTextField(obscureText: false, hintText: "E-mail", icon: const Icon(Icons.mail_outline,color: ColorConstants.priceColor),controller: emailController,),
            CustomTextField(obscureText: true, hintText: "Password", icon: const Icon(Icons.lock_outline,color: ColorConstants.priceColor),controller: passwordController),
            TextButton(onPressed: () {
              context.read<LoginCubit>().login(emailController.text, passwordController.text, context);

            },style: TextButton.styleFrom(backgroundColor: ColorConstants.priceColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                child: Container(width: screenWidth * 0.7,child: const Text("Login",style: TextStyle(color: ColorConstants.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),
            SizedBox(height: screenWidth * 0.14),
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

