import 'package:flutter/material.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/onboard_model.dart';


class OnboardCard extends StatelessWidget {
  OnboardModel model;

  OnboardCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 300,width: 300,child: Image.asset(model.image,alignment: Alignment.center,fit: BoxFit.fitWidth,)),

        Text(model.title,textAlign: TextAlign.center,softWrap: true,style: const TextStyle(color: ColorConstants.black,fontSize: 18,fontWeight: FontWeight.w500),),

        Padding(
          padding: const EdgeInsets.only(right: 64.0,left: 64.0),
          child: Text(model.subtitle,textAlign: TextAlign.center,softWrap: true,style: TextStyle(color: Color(0xFF3B3B3B),fontSize: 12,),),
        )
      ],
    );
  }
}
