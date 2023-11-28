import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/data/entity/basket_response.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/entity/product_response.dart';

class OrderDaoRepository{

  List<ProductModel> parseProductResponse(String response){
    return ProductResponse.fromJson(json.decode(response)).products;
  }
  List<BasketModel> parseBasketModel(String response){
    return BasketResponse.fromJson(json.decode(response)).basket_products;
  }

  Future<List<ProductModel>> getProduct() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseProductResponse(response.data.toString());
  }
  Future<void> addToBasket(String product_name,String product_image_name,String product_price,String product_order_amount,String user_name) async{
    var url ="http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {
      "yemek_adi":product_name,
      "yemek_resim_adi":product_image_name,
      "yemek_fiyat":int.parse(product_price),
      "yemek_siparis_adet":int.parse(product_order_amount),
      "kullanici_adi":user_name};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Add products: ${response.data.toString()}");
  }
  Future<List<BasketModel>> getBasket() async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi":"hakan_baysal"};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    return parseBasketModel(response.data.toString());
  }
  Future<void> deleteProduct(int yemek_sepet_id,String user_name) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"yemek_sepet_id":yemek_sepet_id,"kullanici_adi":user_name};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Delete product: ${response.data.toString()}");
  }
}
