import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:order_app/data/constants/color_constants.dart';



class GoogleNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  GoogleNavBar({super.key, required this.onTabChange});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15),blurRadius: 30,offset: const Offset(0, 10))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      margin: const EdgeInsets.all(10),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        activeColor: ColorConstants.priceColor,
        gap: 10,
        style: GnavStyle.google,
        tabBackgroundColor: ColorConstants.priceColor.withOpacity(0.1),
        tabBorderRadius: 12,
        curve: Curves.ease.flipped,
        tabs: const [
          GButton(padding: EdgeInsets.all(10),icon: Icons.home,text: "Home",iconColor: ColorConstants.priceColor),
          GButton(padding: EdgeInsets.all(10),icon: Icons.shopping_basket,text: "Basket",iconColor: ColorConstants.priceColor,),
          GButton(padding: EdgeInsets.all(10),icon: Icons.favorite_outlined,text: "Favourite",iconColor: ColorConstants.priceColor,),
          GButton(padding: EdgeInsets.all(10),icon: Icons.person,text: "Profile",iconColor: ColorConstants.priceColor,),
        ],
      ),
    );
  }
}
