
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/favourite_model.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class FavouriteCubit extends Cubit<List<FavouriteModel>>{
  FavouriteCubit():super(<FavouriteModel>[]);

  var kRepo = OrderDaoRepository();
  var collectionFavourites = FirebaseFirestore.instance.collection("Favourites");

  Future<void> favouriteList() async{
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var query = collectionFavourites.where("user_id",isEqualTo: userId );
    query.snapshots().listen((event) {
      var list = <FavouriteModel>[];
      var documents = event.docs;
      for(var document in documents){
        var data = document.data();
        var key = document.id;
        var product = FavouriteModel.fromJson(data,key);
        list.add(product);
      }
      emit(list);
    });
  }

}

/// liste şeklinde product details cubit hazır bro gelince bool değeri döndür