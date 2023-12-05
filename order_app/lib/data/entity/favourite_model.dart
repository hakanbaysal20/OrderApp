
class FavouriteModel{
  String product_image_url;
  String product_name;
  String product_id;
  String user_id;

  FavouriteModel(
      {
        required this.product_image_url,
        required this.product_name,
        required this.product_id,
        required this.user_id});
  factory FavouriteModel.fromJson(Map<dynamic,dynamic> json ,String key){
    return FavouriteModel(product_image_url: json["product_image_url"], product_name: "product_name", product_id: "product_id", user_id: "user_id");
  }
}