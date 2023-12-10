import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/basket_cubit_types.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class BasketCubit extends Cubit<BasketCubitTypes>{
  BasketCubit():super(BasketCubitTypes(basketModel: [], totalPrice: 0));

  var pRepo = OrderDaoRepository();

  Future<void> getBasket() async{
    var getList = await pRepo.getBasket();
    emit(state.copyWith(basketModel: getList));
  }
  Future<void> deleteProduct(int yemek_sepet_id) async{
    await pRepo.deleteProduct(yemek_sepet_id);
    getBasket();
    getTotalPrice();
  }
  Future<void> getTotalPrice() async{
    var totalPrice = await pRepo.totalPrice();
    emit(state.copyWith(totalPrice: totalPrice));
  }
}