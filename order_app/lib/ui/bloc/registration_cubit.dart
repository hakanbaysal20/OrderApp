import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class RegistrationCubit extends Cubit<void>{
  RegistrationCubit():super(0);

  var kRepo = OrderDaoRepository();

  Future<void> registration(BuildContext context,String email, String password, String passwordAgain) async{
    await kRepo.registration(context,email, password, passwordAgain);
  }
}