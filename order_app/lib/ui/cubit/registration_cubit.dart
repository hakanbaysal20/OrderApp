import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/authentication_repository.dart';
import 'package:order_app/data/repo/product_repository.dart';

class RegistrationCubit extends Cubit<void>{
  RegistrationCubit():super(0);

  var authRepo = AuthenticationDaoRepository();

  Future<void> registration(BuildContext context,String email, String password, String passwordAgain,String userCity,String userName) async{
    await authRepo.registration(context,email, password, passwordAgain,userName,userCity);
  }
}