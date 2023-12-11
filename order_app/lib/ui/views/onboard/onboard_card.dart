import 'package:flutter/material.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/entity/onboard_model.dart';


class OnboardCard extends StatelessWidget {
  OnboardModel model;

  OnboardCard(this.model);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: screenWidth * 0.7,width: screenWidth * 0.7,child: Image.asset(model.image,alignment: Alignment.center,fit: BoxFit.fitWidth,)),

        Text(model.title,textAlign: TextAlign.center,softWrap: true,style: const TextStyle(color: ColorConstants.black,fontSize: 18,fontWeight: FontWeight.w500),),

        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.16,left: screenWidth * 0.16),
          child: Text(model.subtitle,textAlign: TextAlign.center,softWrap: true,style: TextStyle(color: Color(0xFF3B3B3B),fontSize: 12,),),
        )
      ],
    );
  }
}
