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

class OrderDaoRepository{

  List<ProductModel> parseProductResponse(String response){
    return ProductResponse.fromJson(json.decode(response)).products;
  }
  List<BasketModel> parseBasketModel(String response){
    return BasketResponse.fromJson(json.decode(response)).basket_products;
  }
  var collectionUser = FirebaseFirestore.instance.collection("Users");
  var auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;


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
    var data = {"sepet_yemek_id":yemek_sepet_id,"kullanici_adi":user_name};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Delete product: ${response.data.toString()}");
  }
  Future<void> login(String email,String password,BuildContext context) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
    }catch (e) {
      print("Error");
    }
  }
  Future<void> registration(BuildContext context,String email,String password,String passwordAgain) async{
      try{
        if(password == passwordAgain){
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
          var newUser = HashMap<String,dynamic>();
          newUser["user_email"] = email;
          newUser["user_password"] = password;
          collectionUser.add(newUser);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
        }else{
          print("passwords do not match");
        }
      }on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          print('The password provided is too weak');
        }else if(e.code == 'email-already-in-use'){
          print('The account already exists for that email.');
        }
      }
    catch(e){
        print(e);
      }
  }
  Future<List<ProductModel>> search() async{
    final dio = Dio();
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await dio.get(url,queryParameters: {'yemek_id':5});
    print(response.data.toString());
    return parseProductResponse(response.data.toString());

  }
  Future<void> saveAdress(String adress_name, String adress_city,String adress_district,String adress_directions) async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionAdress = firestore.collection("Users").doc(userId).collection("Address");
    var newAdress = HashMap<String,dynamic>();
    newAdress["adress_id"] = "";
    newAdress["adress_name"] = adress_name;
    newAdress["adress_city"] = adress_city;
    newAdress["adress_district"] = adress_district;
    newAdress["adress_directions"] = adress_directions;
    collectionAdress.add(newAdress);
  }
  Future<void> changeIndicator(int value,TabController tabController) async{
    tabController.animateTo(value);
  }


 // Product Details Cubit
  Future<int> increase(int number) async{
    var total = number + 1;
    return total;
  }
  Future<int> decrease(int number) async{
    var total = number - 1;
    return total;
  }
}
