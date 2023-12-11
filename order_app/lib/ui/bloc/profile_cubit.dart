import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/entity/profile_model.dart';

class ProfileCubit extends Cubit<List<ProfileModel>> {
  ProfileCubit() :super(<ProfileModel>[]);

  var collectionUser = FirebaseFirestore.instance.collection("Users");

  Future<void> getUserInfo() async{
  var userId = FirebaseAuth.instance.currentUser!.uid;
  var query = collectionUser.where("user_id",isEqualTo: userId);
  query.snapshots().listen((value) {
    var userList = <ProfileModel>[];
    var doc = value.docs;
    for(var document in doc){
      var data = document.data();
      var key = document.id;
      var userInfo = ProfileModel.fromJson(data,key);
      userList.add(userInfo);
    }
    emit(userList);
  });
  }
}