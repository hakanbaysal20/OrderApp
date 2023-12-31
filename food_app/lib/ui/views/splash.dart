import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/ui/cubit/splash_cubit.dart';
import 'package:order_app/ui/views/lottie/lottie_widget.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double imageOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
      setState(() {
        imageOpacity = 1;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: ColorConstants.linearColor)),
        child: Column(
          children: [
            buildAnimatedOpacityLottie("splash_anim"),

            const Text("Hello",style: TextStyle(fontFamily: 'Roboto',fontSize: 20,fontWeight: FontWeight.w500,color: ColorConstants.white),),
            const Spacer(),
            Visibility(
              visible: imageOpacity == 1,
              child: SizedBox(
                width: screenWidth * 0.2,
                height: screenWidth * 0.2,
                child: buildAnimatedOpacityLottie("loading"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildAnimatedOpacityLottie(String animateJson){
    return AnimatedOpacity(
      opacity: imageOpacity,
      duration: const Duration(seconds: 3),
      child: LottieCustomWidget("$animateJson"),
      onEnd:() {
        context.read<SplashCubit>().checkUserStatus(context);
      },
    );
  }
}

