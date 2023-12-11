import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app/bottom_nav_bar.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/data/entity/basket_response.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/entity/product_response.dart';
import 'package:order_app/ui/views/login.dart';
import 'package:order_app/ui/views/onboard/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository{
  // Product Response
  List<ProductModel> parseProductResponse(String response){
    return ProductResponse.fromJson(json.decode(response)).products;
  }
  // Basket Response

  // User process
  var collectionUser = FirebaseFirestore.instance.collection("Users");
  var auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // Home Functions
  Future<List<ProductModel>> getProduct() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseProductResponse(response.data.toString());
  }
  Future<List<ProductModel>> sortAscByPriceProduct() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    var productList =  parseProductResponse(response.data.toString());
    Comparator<ProductModel> sortByPrice = (a, b) => int.parse(a.product_price).compareTo(int.parse(b.product_price));
    productList.sort(sortByPrice);
    return productList;
  }
  Future<List<ProductModel>> sortDescByPriceProduct() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    var productList =  parseProductResponse(response.data.toString());
    Comparator<ProductModel> sortByPrice = (a, b) => int.parse(b.product_price).compareTo(int.parse(a.product_price));
    productList.sort(sortByPrice);
    return productList;
  }
  Future<List<ProductModel>> getSearch(String searchedWord) async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    var productList =  parseProductResponse(response.data.toString());
    Iterable<ProductModel> search = productList.where((item) => item.product_name.toLowerCase().contains(searchedWord.toLowerCase()));

    var list = search.toList();
    return list;
  }
  Future<List<ProductModel>> filterProduct(int max, int min) async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    var productList =  parseProductResponse(response.data.toString());
    Iterable<ProductModel> filter = productList.where((producObject) {
      return int.parse(producObject.product_price) > min && int.parse(producObject.product_price) < max;
    });
    var list = filter.toList();
    return list;
  }
  Future<List<ProductModel>> sortByWordProduct() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    var productList =  parseProductResponse(response.data.toString());
    Comparator<ProductModel> sortByWord = (a, b) => a.product_name.compareTo(b.product_name);
    productList.sort(sortByWord);
    return productList;
  }



  // Basket Process
  Future<void> deleteProduct(int yemek_sepet_id) async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id":yemek_sepet_id,"kullanici_adi":userId};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Delete product: ${response.data.toString()}");
  }


  // Login functions

  // Onboard Cubit
  Future<void> changeIndicator(int value,TabController tabController) async{
    tabController.animateTo(value);
  }
 // Product Details Cubit


}
