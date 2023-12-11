import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/entity/onboard_model.dart';
import 'package:order_app/ui/cubit/onboard_cubit.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                }, child: Row(
                  children: [
                    Text("Login",style: TextStyle(color: ColorConstants.priceColor),),
                    Icon(Icons.arrow_forward_ios,color: ColorConstants.priceColor,),
                  ],
                )),
              ],
            ),
          ),
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

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TabPageSelector(
              selectedColor: ColorConstants.priceColor,
              borderStyle: BorderStyle.none,
              indicatorSize: 10,
              color: Colors.black12,
              controller: tabController,
            ),
          ),

        ],
      ),
    );
  }
}
