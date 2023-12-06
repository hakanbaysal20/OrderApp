



enum ImageConstants {

  onboardMeal('im_meal'),
  onboardFood('im_food'),
  onboardDelivery('im_delivery'),
  backgroundImage('im_pattern');
  final String value;

  const ImageConstants(this.value);

  String get toPng => 'assets/images/$value.png';

}