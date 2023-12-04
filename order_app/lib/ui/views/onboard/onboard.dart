import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/data/entity/onboard_model.dart';
import 'package:order_app/ui/bloc/onboard_cubit.dart';
import 'package:order_app/ui/views/login.dart';
import 'package:order_app/ui/views/onboard/onboard_card.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}
class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: OnboardList.onboardItems.length, vsync: this);
  }
// Visibility yarım kaldı çalışmıyor. control değişkeni kontrol et.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: ColorConstants.linearColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SizedBox(
             width: double.infinity,
             height: 420,
             child: PageView.builder(
               onPageChanged: (value) {
                 setState(() {
                 });
                 context.read<OnboardCubit>().changeIndicator(value, tabController);
               },
               itemCount: OnboardList.onboardItems.length,
               itemBuilder: (context, index) {
                 return OnboardCard(OnboardList.onboardItems[index],
                    );
                 },),
           ),
            TabPageSelector(
               selectedColor: ColorConstants.white,
               indicatorSize: 10,
               color: Colors.black54,
               controller: tabController,
             ),
            const SizedBox(height: 80),
           TextButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),));
              },style: TextButton.styleFrom(backgroundColor: ColorConstants.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37))),
                  child: const SizedBox(width: 150,child: Text("Get a meal",style: TextStyle(color: ColorConstants.buttonTextColor,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),


          ],
        ),
      ),
    );
  }
}
