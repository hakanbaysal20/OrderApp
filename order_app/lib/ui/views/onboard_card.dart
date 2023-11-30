import 'package:flutter/material.dart';
import 'package:order_app/data/entity/onboard_model.dart';


class OnboardCard extends StatelessWidget {
  OnboardModel model;

  OnboardCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32.0,left: 32.0),
          child: Text(model.subtitle),
        ),
        Image.asset(model.image),
      ],
    );
  }
}
