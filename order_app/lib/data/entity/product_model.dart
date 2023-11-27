class ProductModel{
  String product_id;
  String product_name;
  String product_image;
  String product_price;

  ProductModel(
      {required this.product_id,
      required this.product_name,
      required this.product_image,
      required this.product_price});

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
        product_id: json["yemek_id"] as String,
        product_name: json["yemek_adi"] as String,
        product_image: json["yemek_resim_adi"] as String,
        product_price: json["yemek_fiyat"] as String);
  }
}