import 'package:flutter/material.dart';
import 'package:order_app/data/constants/string_constants.dart';

class ContainerItem extends StatelessWidget {
  String info;
  String userInfo;
  ContainerItem({
    super.key,required this.info,required this.userInfo
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(info,style: const TextStyle(fontSize: 14,fontFamily: StringConstants.primaryFontFamily),),
          Text(userInfo,style: const TextStyle(fontSize: 14,fontFamily: StringConstants.primaryFontFamily)),
        ],
      ),
    );
  }
}