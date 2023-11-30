

import 'package:order_app/enums/image_constants.dart';

class OnboardModel{
  String image;
  String title;
  String subtitle;
  OnboardModel({required this.image,required this.title,required this.subtitle});

}


class OnboardList {

  static List<OnboardModel> onboardItems = [
    OnboardModel(image: ImageConstants.onboardDelivery.toPng, title: "", subtitle: "Enjoy instant delivery and payment"),
    OnboardModel(image: ImageConstants.onboardFood.toPng, title: "", subtitle: "Choos from a wide range of delicious meals"),
    OnboardModel(image: ImageConstants.onboardMeal.toPng, title: "title", subtitle: "Go to login"),
  ];


}