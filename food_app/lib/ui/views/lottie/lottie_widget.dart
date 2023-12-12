import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LottieCustomWidget extends StatelessWidget {
  final String path;

  LottieCustomWidget(this.path);
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie/$path.json",
    );
  }
}
