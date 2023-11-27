class BasketModel{
  String basket_product_id;
  String product_name;
  String product_image_name;
  String product_price;
  String product_order_amount;
  String user_name;

  BasketModel(
      {required this.basket_product_id,
      required this.product_name,
      required this.product_image_name,
      required this.product_price,
      required this.product_order_amount,
      required this.user_name});

  factory BasketModel.fromJson(Map<String,dynamic> json){
    return BasketModel(
        basket_product_id: json["sepet_yemek_id"] as String,
        product_name: json["yemek_adi"] as String,
        product_image_name: json["yemek_resim_adi"] as String,
        product_price: json["yemek_fiyat"] as String,
        product_order_amount: json["yemek_siparis_adet"] as String,
        user_name: json["kullanici_adi"] as String,
    );
  }
}