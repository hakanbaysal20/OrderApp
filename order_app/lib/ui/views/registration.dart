import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/ui/bloc/registration_cubit.dart';
import 'package:order_app/ui/views/widgets/customTextField.dart';

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
      body: SingleChildScrollView(
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
                      }, icon: Icon(Icons.arrow_back_ios,color: ColorConstants.priceColor,size: 35,)),
                ],
              ),
            ),

            Image.asset("assets/images/ic_logo.png",color: ColorConstants.priceColor,),
            const Text("Foodi",style: TextStyle(color: ColorConstants.priceColor,fontFamily: 'Roboto' ,fontSize: 42,fontWeight: FontWeight.w500)),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: ColorConstants.priceColor,fontWeight: FontWeight.w500),),
            ),
            CustomTextField(obscureText: false, hintText: "E-mail", icon: const Icon(Icons.mail_outline,color: ColorConstants.priceColor),controller: emailController,),
            CustomTextField(obscureText: true, hintText: "Password", icon: const Icon(Icons.lock_outline,color: ColorConstants.priceColor),controller: passwordController),
            CustomTextField(obscureText: true, hintText: "Password Again", icon: const Icon(Icons.lock_outline,color: ColorConstants.priceColor),controller: passwordAgainController),

            TextButton(onPressed: () {
              context.read<RegistrationCubit>().registration(context,emailController.text, passwordController.text, passwordAgainController.text);

            },style: TextButton.styleFrom(backgroundColor: ColorConstants.priceColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                child: Container(width: 300,child: const Text("Sign up",style: TextStyle(color: ColorConstants.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),

          ],
        ),
      ),
    );
  }
}
