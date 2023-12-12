import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/basket_cubit_types.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/data/repo/basket_repo.dart';
import 'package:order_app/data/repo/product_repository.dart';

class BasketCubit extends Cubit<BasketCubitTypes>{
  BasketCubit():super(BasketCubitTypes(basketModel: <BasketModel>[], totalPrice: 0));

  var basketRepo = BasketRepository();
  var productRepo = ProductRepository();

  Future<void> getBasket() async{
    var getList = await basketRepo.getBasket();
    emit(state.copyWith(basketModel: getList));
  }
  Future<void> deleteProduct(int yemek_sepet_id) async{
    await productRepo.deleteProduct(yemek_sepet_id);
    getBasket();
    getTotalPrice();
  }
  Future<void> getTotalPrice() async{
    var totalPrice = await basketRepo.totalPrice();
    emit(state.copyWith(totalPrice: totalPrice));
  }
}