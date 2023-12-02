import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/data/repo/order_dao_repository.dart';

class HomeCubit extends Cubit<List<ProductModel>>{
  HomeCubit():super(<ProductModel>[]);

  var pRepo = OrderDaoRepository();
  Future<void> loadProducts() async {
    var list = await pRepo.getProduct();
    emit(list);
  }
  Future<void> addToBasket(String product_name,String product_image_name,String product_price, String product_order_amount,String user_name) async{
    await pRepo.addToBasket(product_name, product_image_name, product_price, product_order_amount, user_name);
  }
  Future<void> search() async{
    var list = await pRepo.search();
    emit(list);
  }
}