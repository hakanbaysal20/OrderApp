
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/authentication_repository.dart';
import 'package:order_app/data/repo/product_repository.dart';

class SplashCubit extends Cubit<void>{
  SplashCubit():super(0);
  var authRepo = AuthenticationDaoRepository();
  Future<void> checkUserStatus(BuildContext context) async{
    await authRepo.checkUserStatus(context);
  }
}