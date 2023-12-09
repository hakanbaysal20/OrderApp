import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/basket_model.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class BasketCubit extends Cubit<List<BasketModel>>{
  BasketCubit():super(<BasketModel>[]);

  var pRepo = OrderDaoRepository();

  Future<void> getBasket() async{
    var getList = await pRepo.getBasket();
    emit(getList);
  }
  Future<void> deleteProduct(int yemek_sepet_id) async{
    await pRepo.deleteProduct(yemek_sepet_id);
    getBasket();
  }
}