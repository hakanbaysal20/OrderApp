

import 'package:order_app/enums/image_constants.dart';

class OnboardModel{
  String image;
  String title;
  String subtitle;
  OnboardModel({required this.image,required this.title,required this.subtitle});

}


class OnboardList {

  static List<OnboardModel> onboardItems = [
    OnboardModel(image: ImageConstants.onboardOne.toPng, title: "Select The Favorites Menu", subtitle: "Now eat well, don't leave the house,You can choose your favorite food only with one click"),
    OnboardModel(image: ImageConstants.onboardFav.toPng, title: "Good food at a cheap price", subtitle: "You can eat at expensive restaurants with afforable price"),
  ];


}