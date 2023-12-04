import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/ui/bloc/registration_cubit.dart';
import 'package:order_app/ui/views/customTextField.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordAgainController = TextEditingController();
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
            colors: ColorConstants.linearColor,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios,color: ColorConstants.white,size: 35,)),
                  ],
                ),
              ),

              Image.asset("assets/images/ic_logo.png"),
              const Text("Foodi",style: TextStyle(color: ColorConstants.white,fontFamily: 'Roboto' ,fontSize: 42,fontWeight: FontWeight.w500)),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: ColorConstants.white,fontWeight: FontWeight.w500),),
              ),
              CustomTextField(obscureText: false, hintText: "E-mail", icon: const Icon(Icons.mail_outline,color: ColorConstants.white),controller: emailController,),
              CustomTextField(obscureText: true, hintText: "Password", icon: const Icon(Icons.lock_outline,color: ColorConstants.white),controller: passwordController),
              CustomTextField(obscureText: true, hintText: "Password Again", icon: const Icon(Icons.lock_outline,color: ColorConstants.white),controller: passwordAgainController),

              TextButton(onPressed: () {
                context.read<RegistrationCubit>().registration(context,emailController.text, passwordController.text, passwordAgainController.text);

              },style: TextButton.styleFrom(backgroundColor: ColorConstants.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37))),
                  child: Container(width: 300,child: const Text("Sign up",style: TextStyle(color: ColorConstants.buttonTextColor,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),

            ],
          ),
        ),
      ),
    );
  }
}
