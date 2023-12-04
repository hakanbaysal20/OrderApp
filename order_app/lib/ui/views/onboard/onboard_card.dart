import 'package:flutter/material.dart';
import 'package:order_app/data/entity/onboard_model.dart';


class OnboardCard extends StatelessWidget {
  OnboardModel model;

  OnboardCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 300,width: 300,child: Image.asset(model.image,alignment: Alignment.center)),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(model.subtitle,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }
}
