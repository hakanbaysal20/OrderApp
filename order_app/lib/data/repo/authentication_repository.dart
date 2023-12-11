import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app/bottom_nav_bar.dart';
import 'package:order_app/ui/views/login.dart';
import 'package:order_app/ui/views/onboard/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationDaoRepository{
  // User process
  var collectionUser = FirebaseFirestore.instance.collection("Users");
  var auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

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
  Future<bool> checkFavorite(product_id) async{
    var checkFavourite = false;
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionFavourites = firestore.collection("Favourites");
    QuerySnapshot querySnapshot = await collectionFavourites
        .where("product_id",isEqualTo: product_id)
        .where("user_id",isEqualTo: userId)
        .get();
    if(querySnapshot.docs.isNotEmpty){
      print("dolu");
      return checkFavourite = true;
    }else{
      return checkFavourite = false;
    }
  }
  Future<void> saveFavorite(String product_name,String product_image_name,String product_id) async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionFavourites = firestore.collection("Favourites");
    var favouriteProduct = HashMap<String,dynamic>();
    favouriteProduct["product_name"] = product_name;
    favouriteProduct["product_id"] = product_id;
    favouriteProduct["user_id"] = userId;
    favouriteProduct["product_image_url"] = "http://kasimadalan.pe.hu/yemekler/resimler/$product_image_name";
    collectionFavourites.add(favouriteProduct);
  }
  Future<void> deleteFavorite(String product_id) async{
    final collectionFavourites = firestore.collection("Favourites");
    QuerySnapshot snapshot = await collectionFavourites.where("product_id",isEqualTo: product_id).get();
    collectionFavourites.doc(snapshot.docs[0].id).delete();
  }




}