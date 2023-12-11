import 'package:flutter/material.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/constants/string_constants.dart';
import 'package:order_app/enums/image_constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageConstants.backgroundImage.toPng),alignment: Alignment.topRight),
          color: ColorConstants.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(color: ColorConstants.red.withOpacity(0.1),borderRadius: const BorderRadius.all(Radius.circular(12))),
                    child: IconButton(onPressed: () {

                        }, icon: const Icon(Icons.notifications_none_outlined,color: ColorConstants.priceColor,)),
                      ),
                    ],
                  ),
                ),
                const Text(StringConstants.personalInfo,style: TextStyle(fontFamily: StringConstants.primaryFontFamily,fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.only(right: 32,left: 32),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)),border: Border.all(color: ColorConstants.blackLight)),
                    child: Column(
                      children: [
                        ContainerItem(info: StringConstants.yourName,userInfo: "Hakan Baysal"),
                        ContainerItem(info: StringConstants.city,userInfo: "Denizli"),
                      ],
                    ),
                  ),
                ),
                const Text(StringConstants.contactInfo,style: TextStyle(fontFamily: StringConstants.primaryFontFamily,fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.only(right: 32,left: 32),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)),border: Border.all(color: ColorConstants.blackLight)),
                    child: Column(
                      children: [

                        ContainerItem(info: StringConstants.email, userInfo: "admin@gmail.com"),
                      ],
                    ),
                  ),
                ),
              ],
        ),
      ),
    );
  }
}

class ContainerItem extends StatelessWidget {
  String info;
  String userInfo;
   ContainerItem({
    super.key,required this.info,required this.userInfo
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
