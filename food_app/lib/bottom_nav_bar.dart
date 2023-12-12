import 'package:flutter/material.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/ui/components/riverpood/google_nav_bar.dart';
import 'package:order_app/ui/views/navigation_items/basket.dart';
import 'package:order_app/ui/views/navigation_items/favorite.dart';
import 'package:order_app/ui/views/navigation_items/home.dart';
import 'package:order_app/ui/views/navigation_items/profile.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [const Home(), const Basket(),const Favorite(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      bottomNavigationBar: GoogleNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: pages[selectedIndex],
    );
  }
}