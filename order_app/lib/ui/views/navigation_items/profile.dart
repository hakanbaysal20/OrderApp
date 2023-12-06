import 'package:flutter/material.dart';
import 'package:order_app/constants/color_constants.dart';
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
                    decoration: BoxDecoration(color: Color(0xFFFF0000).withOpacity(0.1),borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: IconButton(onPressed: () {

                    }, icon: Icon(Icons.notifications_none_outlined,color: ColorConstants.priceColor,)),
                  ),
                ],
              ),
            ),
            Text("Personal Info",style: TextStyle(fontFamily: 'SansPro',fontSize: 16),),
            Padding(
              padding: const EdgeInsets.only(right: 32,left: 32),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),border: Border.all(color: Colors.black12)),
                child: Column(
                  children: [
                    ContainerItem(info: "Your name",userInfo: "Hakan Baysal"),
                    ContainerItem(info: "Country",userInfo: "Turkey"),
                    ContainerItem(info: "City",userInfo: "Denizli"),
                  ],
                ),
              ),
            ),
            Text("Contact Info",style: TextStyle(fontFamily: 'SansPro',fontSize: 16),),
            Padding(
              padding: const EdgeInsets.only(right: 32,left: 32),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),border: Border.all(color: Colors.black12)),
                child: Column(
                  children: [

                    ContainerItem(info: "Email", userInfo: "admin@gmail.com"),
                    ContainerItem(info: "Phone Number", userInfo: "0555 555 55 55"),
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
          Text(info,style: TextStyle(fontSize: 14,fontFamily: 'SansPro'),),
          Text(userInfo,style: TextStyle(fontSize: 14,fontFamily: 'SansPro')),
        ],
      ),
    );
  }
}
