import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/constants/string_constants.dart';
import 'package:order_app/data/entity/profile_model.dart';
import 'package:order_app/enums/image_constants.dart';
import 'package:order_app/ui/cubit/profile_cubit.dart';
import 'package:order_app/ui/views/login.dart';
import 'package:order_app/ui/widgets/container.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageConstants.backgroundImage.toPng),alignment: Alignment.topRight),
          color: ColorConstants.white,
        ),
        child: BlocBuilder<ProfileCubit,List<ProfileModel>>(
          builder: (context,userList) {
            return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context,info) {
              var user = userList[info];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.04),
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
                    SizedBox(height: screenWidth * 0.35),
                    const Text(StringConstants.personalInfo,style: TextStyle(fontFamily: StringConstants.primaryFontFamily,fontSize: 16),),
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.08,left: screenWidth * 0.08),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)),border: Border.all(color: ColorConstants.blackLight)),
                        child: Column(
                          children: [
                            ContainerItem(info: StringConstants.yourName,userInfo: user.user_name),
                            ContainerItem(info: StringConstants.city,userInfo: user.city),
                          ],
                        ),
                      ),
                    ),
                    const Text(StringConstants.contactInfo,style: TextStyle(fontFamily: StringConstants.primaryFontFamily,fontSize: 16),),
                    Padding(padding: EdgeInsets.only(right: screenWidth * 0.08,left: screenWidth * 0.08),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)),border: Border.all(color: ColorConstants.blackLight)),
                        child: Column(
                          children: [
                            ContainerItem(info: StringConstants.email, userInfo: user.user_email),
                            TextButton(onPressed: () async{
                              context.read<ProfileCubit>().signOut();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login(),));
                              }, child: const Text("Sign out",style: TextStyle(color: ColorConstants.priceColor,fontFamily: StringConstants.primaryFontFamily),)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            });
          }
        ),
              ),
          );
        }

  }


