
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/list_type.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class ProductDetailsCubit extends Cubit<ListType>{
  ProductDetailsCubit():super(ListType(checkFavourite: false, productAmount: 1));

  var kRepo = OrderDaoRepository();
  Future<void> increase(int number) async{
   var value = await kRepo.increase(number);
   emit(state.copyWith(productAmount: value));
  }
  Future<void> decrease(int number) async{
    var value = await kRepo.decrease(number);
    emit(state.copyWith(productAmount: value));
  }

  Future<void> addToBasket(String product_name,String product_image_name,String product_price, String product_order_amount) async{
    await kRepo.addToBasket(product_name, product_image_name, product_price, product_order_amount);
  }
  Future<void> checkFavourite(String product_id) async{
    var value = await kRepo.checkFavourite(product_id);
    emit(state.copyWith(checkFavourite: value));
  }
  Future<void> saveFavourite(String product_name, String product_image_name,String product_id) async{
    await kRepo.saveFavourite(product_name, product_image_name, product_id);
  }
  Future<void> deleteFavourite(String product_id) async{
    await kRepo.deleteFavourite(product_id);
  }


}