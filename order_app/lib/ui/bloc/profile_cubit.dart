import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/entity/profile_model.dart';

class ProfileCubit extends Cubit<List<ProfileModel>> {
  ProfileCubit() :super(<ProfileModel>[]);

}