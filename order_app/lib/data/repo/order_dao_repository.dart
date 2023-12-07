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

class OrderDaoRepository{
  // Product Response
  List<ProductModel> parseProductResponse(String response){
    return ProductResponse.fromJson(json.decode(response)).products;
  }
  // Basket Response
  List<BasketModel> parseBasketModel(String response){
    return BasketResponse.fromJson(json.decode(response)).basket_products;
  }
  // User process
  var collectionUser = FirebaseFirestore.instance.collection("Users");
  var auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // Home Process
  Future<List<ProductModel>> getProduct() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseProductResponse(response.data.toString());
  }
  Future<void> addToBasket(String product_name,String product_image_name,String product_price,String product_order_amount) async{
    var url ="http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var user_id = FirebaseAuth.instance.currentUser!.uid;
    var data = {
      "yemek_adi":product_name,
      "yemek_resim_adi":product_image_name,
      "yemek_fiyat":int.parse(product_price),
      "yemek_siparis_adet":int.parse(product_order_amount),
      "kullanici_adi":user_id};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Add products: ${response.data.toString()}");
  }

  // Basket Process
  Future<void> deleteProduct(int yemek_sepet_id,String user_name) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id":yemek_sepet_id,"kullanici_adi":user_name};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("Delete product: ${response.data.toString()}");
  }
  Future<List<BasketModel>> getBasket() async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": userId};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    return parseBasketModel(response.data.toString());
  }
  Future<int> totalPrice(int product_amount, int product_price) async{
    var total = product_amount * product_price;
    return total;
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

  // Onboard Cubit
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

  // Splash management
  Future<void> checkUserStatus(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = (preferences.getBool('seen') ?? false);
    var user = auth.currentUser;
    if(seen){
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      }
    }else{
      await preferences.setBool('seen', true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Onboard(),));
    }
  }
  // Favourite Process
  Future<bool> checkFavourite(product_id) async{
    var checkFavourite = false;
    final collectionFavourites = firestore.collection("Favourites");
    QuerySnapshot querySnapshot = await collectionFavourites.where("product_id",isEqualTo: product_id).get();
    if(querySnapshot.docs.isNotEmpty){
      print("dolu");
      return checkFavourite = true;
    }else{
      return checkFavourite = false;
    }
  }
  Future<void> saveFavourite(String product_name,String product_image_name,String product_id) async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionFavourites = firestore.collection("Favourites");
    var favouriteProduct = HashMap<String,dynamic>();
      favouriteProduct["product_name"] = product_name;
      favouriteProduct["product_id"] = product_id;
      favouriteProduct["user_id"] = userId;
      favouriteProduct["product_image_url"] = "http://kasimadalan.pe.hu/yemekler/resimler/$product_image_name";
      collectionFavourites.add(favouriteProduct);
  }
  Future<void> deleteFavourite(String product_id) async{
    final collectionFavourites = firestore.collection("Favourites");
    QuerySnapshot snapshot = await collectionFavourites.where("product_id",isEqualTo: product_id).get();
    collectionFavourites.doc(snapshot.docs[0].id).delete();
  }
}
