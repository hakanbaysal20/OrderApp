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
        try{
          return BasketResponse.fromJson(json.decode(response)).basket_products;
        }catch (e){
          return [];
        }
  }
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
  Future<void> deleteProduct(int yemek_sepet_id) async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id":yemek_sepet_id,"kullanici_adi":userId};
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
  Future<int> totalPrice() async{
    var getProducts = await getBasket();
    var total = 0;
    if(getProducts.isEmpty){
      return total;
    }else{
      for(BasketModel i in getProducts){
        total += int.parse(i.product_price) * int.parse(i.product_order_amount);
      }
    }
    return total;
  }
  // Login functions
  Future<void> login(String email,String password,BuildContext context) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
    }catch (e) {
      print("Error");
    }
  }
  Future<void> registration(BuildContext context,String email,String password,String passwordAgain,String userCity,String userName) async{
      try{
        if(password == passwordAgain){
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
          var newUser = HashMap<String,dynamic>();
          var userId = FirebaseAuth.instance.currentUser!.uid;
          newUser["user_name"] = userName;
          newUser["user_email"] = email;
          newUser["user_password"] = password;
          newUser["user_city"] = userCity;
          newUser["user_id"] = userId;
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
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
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
