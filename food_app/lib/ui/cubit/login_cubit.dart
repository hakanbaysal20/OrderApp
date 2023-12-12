import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/authentication_repository.dart';
import 'package:order_app/data/repo/product_repository.dart';

class LoginCubit extends Cubit<void>{
  LoginCubit():super(0);

  var authRepo = AuthenticationDaoRepository();
  Future<void> login(String email,String password,BuildContext context) async{
    await authRepo.login(email, password, context);
  }
}