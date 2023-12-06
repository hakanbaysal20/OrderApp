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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
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
          Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {

                }, child: Text("Skip",style: TextStyle(color: ColorConstants.black,fontSize: 16),)),
                TabPageSelector(
                  selectedColor: ColorConstants.priceColor,
                  borderStyle: BorderStyle.none,
                  indicatorSize: 10,
                  color: Colors.black12,
                  controller: tabController,
                ),
                IconButton(onPressed: () {

                }, icon: Icon(Icons.arrow_forward_ios,color: ColorConstants.priceColor,))
              ],
            ),
          ),

        ],
      ),
    );
  }
}
