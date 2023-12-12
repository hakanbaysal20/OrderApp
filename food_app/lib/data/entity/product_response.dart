
import 'package:order_app/data/entity/product_model.dart';

class ProductResponse{
  List<ProductModel> products;
  int success;

  ProductResponse({required this.products,required this.success});

  factory ProductResponse.fromJson(Map<String,dynamic> json){
    int success = json["success"] as int;
    var jsonArray = json["yemekler"] as List;
    List<ProductModel> products = jsonArray.map((jsonArrayObject) => ProductModel.fromJson(jsonArrayObject)).toList();

    return ProductResponse(products: products, success: success);

  }
}