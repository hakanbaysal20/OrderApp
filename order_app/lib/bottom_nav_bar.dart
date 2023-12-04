import 'package:flutter/material.dart';
import 'package:order_app/components/riverpood/google_nav_bar.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/ui/views/basket.dart';
import 'package:order_app/ui/views/home.dart';
import 'package:order_app/ui/views/profile.dart';


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

  final List<Widget> pages = [const Home(), const Basket(), const Profile()];

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