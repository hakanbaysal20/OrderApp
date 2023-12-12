import 'package:order_app/data/entity/basket_model.dart';

class BasketResponse{
  List<BasketModel> basket_products;
  int success;

  BasketResponse({required this.basket_products,required this.success});

  factory BasketResponse.fromJson(Map<String,dynamic> json){
    int success = json["success"] as int;
    var jsonArray = json["sepet_yemekler"] as List;
    List<BasketModel> basket_products = jsonArray.map((jsonArrayObject) => BasketModel.fromJson(jsonArrayObject)).toList();

    return BasketResponse(basket_products: basket_products, success: success);
  }
}