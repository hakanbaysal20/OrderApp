
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class ProductDetailsCubit extends Cubit<int>{
  ProductDetailsCubit():super(1);

  var kRepo = OrderDaoRepository();
  Future<void> increase(int number) async{
   var value = await kRepo.increase(number);
   emit(value);
  }
  Future<void> decrease(int number) async{
    var value = await kRepo.decrease(number);
    emit(value);
  }
}