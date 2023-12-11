import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/product_repository.dart';

class OnboardCubit extends Cubit<void>{
  OnboardCubit():super(0);
  var productRepo = ProductRepository();
  Future<void> changeIndicator(int value,TabController tabController) async{
    await productRepo.changeIndicator(value, tabController);
  }

}