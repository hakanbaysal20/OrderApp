
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/list_type.dart';
import 'package:order_app/data/repo/authentication_repository.dart';
import 'package:order_app/data/repo/basket_repo.dart';
import 'package:order_app/data/repo/product_repository.dart';

class ProductDetailsCubit extends Cubit<ListType>{
  ProductDetailsCubit():super(ListType(checkFavourite: false, productAmount: 1));

  var productRepo = ProductRepository();
  var authRepo = AuthenticationDaoRepository();
  var basketRepo = BasketRepository();
  Future<void> increase(int number) async{
   var value = await basketRepo.increase(number);
   emit(state.copyWith(productAmount: value));
  }
  Future<void> decrease(int number) async{
    var value = await basketRepo.decrease(number);
    emit(state.copyWith(productAmount: value));
  }
  Future<void> addToBasket(String product_name,String product_image_name,String product_price, String product_order_amount) async{
    await basketRepo.addToBasket(product_name, product_image_name, product_price, product_order_amount);
  }
  Future<void> checkFavorite(String product_id) async{
    var value = await authRepo.checkFavorite(product_id);
    emit(state.copyWith(checkFavourite: value));
  }
  Future<void> saveFavourite(String product_name, String product_image_name,String product_id) async{
    await authRepo.saveFavorite(product_name, product_image_name, product_id);
  }
  Future<void> deleteFavourite(String product_id) async{
    await authRepo.deleteFavorite(product_id);
  }


}