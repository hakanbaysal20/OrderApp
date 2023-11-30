import 'package:flutter/material.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/onboard_model.dart';
import 'package:order_app/ui/views/onboard_card.dart';


class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [ColorConstants.gradientColor, ColorConstants.gradientColorLight ])),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: OnboardList.onboardItems.length,
                  itemBuilder: (context, index) {
                    return OnboardCard(OnboardList.onboardItems[index]
                    );

                },),
            ),
          ],
        ),
      ),
    );
  }
}
