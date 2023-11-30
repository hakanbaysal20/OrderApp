import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class LoginCubit extends Cubit<void>{
  LoginCubit():super(0);

  var kRepo = OrderDaoRepository();
  Future<void> login(String email,String password,BuildContext context) async{
    await kRepo.login(email, password, context);
  }
}