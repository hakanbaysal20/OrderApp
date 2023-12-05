
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class SplashCubit extends Cubit<void>{
  SplashCubit():super(0);
  var kRepo = OrderDaoRepository();
  Future<void> checkUserStatus(BuildContext context) async{
    await kRepo.checkUserStatus(context);
  }
}