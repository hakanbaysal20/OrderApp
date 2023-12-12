import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/data/entity/basket_response.dart';
import 'package:order_app/data/repo/product_repository.dart';

class BasketRepository{
  List<BasketModel> parseBasketModel(String response){
    try{
      return BasketResponse.fromJson(json.decode(response)).basket_products;
    }catch (e){
      return [];
    }
  }
  var productRepo = ProductRepository();
  Future<void> addToBasket(String product_name,String product_image_name,String product_price,String product_order_amount) async{
    var url ="http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var user_id = FirebaseAuth.instance.currentUser!.uid;
    var currentBasket = await getBasket();
    var total = 0;
    for(var product in currentBasket){
      if(product.product_name == product_name){
        total = total + int.parse(product.product_order_amount);
        productRepo.deleteProduct(int.parse(product.basket_product_id));
      }
    }
    total = total + int.parse(product_order_amount);
    var data = {
      "yemek_adi":product_name,
      "yemek_resim_adi":product_image_name,
      "yemek_fiyat":int.parse(product_price),
      "yemek_siparis_adet": total,
      "kullanici_adi":user_id};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Add products: ${response.data.toString()}");
  }

  Future<int> totalPrice() async{
    var getProducts = await getBasket();
    var total = 0;
    if(getProducts.isEmpty){
      return total;
    }else{
      for(var i in getProducts){
        total += int.parse(i.product_price) * int.parse(i.product_order_amount);
      }
    }
    return total;
  }
  Future<List<BasketModel>> getBasket() async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": userId};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    return parseBasketModel(response.data.toString());
  }
  Future<int> increase(int number) async{
    var total = number + 1;
    return total;
  }
  Future<int> decrease(int number) async{
    var total = number - 1;
    return total;
  }
}