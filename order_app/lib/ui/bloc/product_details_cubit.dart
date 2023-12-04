
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
  Future<void> addToBasket(String product_name,String product_image_name,String product_price, String product_order_amount,String user_name) async{
    await kRepo.addToBasket(product_name, product_image_name, product_price, product_order_amount, user_name);
  }
}