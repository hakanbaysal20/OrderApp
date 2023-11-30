import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class OnboardCubit extends Cubit<void>{
  OnboardCubit():super(0);
  var kRepo = OrderDaoRepository();
  Future<void> changeIndicator(int value,TabController tabController) async{
    await kRepo.changeIndicator(value, tabController);
  }

}